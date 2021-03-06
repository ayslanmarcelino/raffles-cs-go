# frozen_string_literal: true

module Admins
  class SkinsController < AdminsController
    before_action :set_skin, only: %w[show edit update destroy]
    before_action :set_transaction, only: %w[new create edit]

    def index
      @q = Skin.includes(:steam_account)
               .joins(:steam_account)
               .where("steam_accounts.user_id = #{current_user.id}")
               .ransack(params[:q])

      @skins = @q.result(distinct: true)
      @all_skins = Skin.joins(:steam_account).where('steam_accounts.user_id' => current_user.id)
      @available_skins = Skin.joins(:steam_account)
                              .where('steam_accounts.user_id' => current_user.id, is_available: true)
      @steam_accounts = SteamAccount.where(user_id: current_user.id)
                                    .order(:description)
    end

    def new
      @skin = Skin.new
    end

    def create
      @skin = Skin.new(params_skin)

      @skin.save ? (redirect_to admins_skins_path, notice: 'Skin cadastrada com sucesso') : (render :new)
    end

    def edit; end

    def update
      @skin.update(params_skin) ? (redirect_to admins_skins_path, notice: 'Skin atualizada com sucesso') : (render :edit)
    end

    def destroy
      @skin.destroy ? (redirect_to admins_skins_path, notice: 'Skin excluída com sucesso') : (render :index)
    end

    def search
      @steam_account = SteamAccount.find_by(id: search_params[:steam_account_id])

      search_skins
    end

    def refresh_skins
      @steam_account = SteamAccount.find_by(id: search_params[:steam_account_id])

      update_skins
    end

    def refresh_skins_job
      SteamAccount.all.each do |skin|
        @steam_account = SteamAccount.find_by(id: skin.id)
        update_skins
      end
    end

    def destroy_multiple
      Skin.destroy(params[:skins])
      respond_to do |format|
        format.html { redirect_to admins_skins_path, notice: 'Skins excluídas com sucesso' }
      end
    end

    private

    def search_params
      params.permit(:steam_account_id)
    end

    def set_skin
      if current_user.steam_account_ids.include?(Skin.find(params[:id]).steam_account.id)
        @skin = Skin.find(params[:id])
      else
        redirect_to root_path, notice: 'Você não tem permissão para manipular esta skin.'
      end
    end

    def set_transaction
      @transactions = Transaction.where(user_id: current_user.id)
                                 .order(created_at: :desc)
    end

    def params_skin
      params.require(:skin).permit(:description, :float, :price_steam,
                                   :price_csmoney, :price_paid, :sale_price,
                                   :is_stattrak, :has_sticker, :is_available,
                                   :transaction_id, :ignore_financial)
    end

    def search_skins
      requisition_api

      @skins_api.each do |skin|
        inspect_url = skin['actions'].first['link'] if skin['actions'].present?
        assetid = assetid(@rg_inventory, skin['classid'])
        skin_large = skin['icon_url_large']
        skin_standard = skin['icon_url']
        icon_url = skin_large.present? ? skin_large : skin_standard
        skin_image_url = "https://steamcommunity-a.akamaihd.net/economy/image/#{icon_url}"
        exists_skin = Skin.find_by(id_steam: assetid)

        next if skin['marketable'] == 0
        next if exists_skin
        next if skin['type'] == 'Base Grade Container'
        next if skin['type'] == 'Base Grade Graffiti'
        next if skin['type'] == 'Extraordinary Collectible'
        next if skin['type'] == 'Base Grade Tool'
        next if skin['type'] == 'Base Grade Pass'

        skin_model = Skin.new
        skin_model.id_steam = assetid
        skin_model.description = skin['name']
        skin_model.description_color = skin['name_color']
        skin_model.exterior = skin['descriptions'].present? ? exterior(skin) : 'Nenhum'
        skin_model.image_skin = skin_image_url
        skin_model.float = skin['actions'].present? ? inspect_skin(assetid, inspect_url) : 0
        skin_model.price_steam = price_steam(skin['market_name'])
        skin_model.first_price_steam = price_steam(skin['market_name'])
        skin_model.has_sticker = sticker?(skin)
        skin_model.name_sticker = name_sticker(skin)
        skin_model.image_sticker = image_sticker(skin)
        skin_model.is_stattrak = stattrak?(skin)
        skin_model.expiration_date = skin['cache_expiration'] if skin['cache_expiration']
        skin_model.inspect_url = inspect_in_game(assetid, inspect_url) if inspect_url.present?
        skin_model.steam_account_id = params[:steam_account_id]
        skin_model.type_skin = skin['tags'].first['name']
        skin_model.type_weapon = skin['tags'].second['name']
        skin_model.has_name_tag = true if skin['fraudwarnings'].present?
        skin_model.description_name_tag = skin['fraudwarnings'].present? ? description_name_tag(skin['fraudwarnings']) : '' 
        skin_model.save
      end
    end

    def update_skins
      requisition_api

      @skins_api.each do |skin|
        assetid = assetid(@rg_inventory, skin['classid'])
        exists_skin = Skin.find_by(id_steam: assetid, is_available: true)
        sleep(10)

        if exists_skin
          exists_skin.price_steam = price_steam(skin['market_name'])
          exists_skin.has_sticker = sticker?(skin)
          exists_skin.name_sticker = name_sticker(skin)
          exists_skin.image_sticker = image_sticker(skin)
          exists_skin.has_name_tag = true if skin['fraudwarnings'].present?
          exists_skin.description_name_tag = skin['fraudwarnings'].present? ? description_name_tag(skin['fraudwarnings']) : '' 
          exists_skin.save
          next
        end
      end
    end

    def requisition_api
      url = "https://steamcommunity.com/id/#{@steam_account.url}/inventory/json/730/2"
      resp = RestClient.get(url)
      @rg_inventory = JSON.parse(resp.body)['rgInventory'].reverse_each.to_a
      @skins_api = JSON.parse(resp.body)['rgDescriptions'].values.reverse
    end

    def exterior(skin)
      skin['descriptions'].each do |description|
        if /Exterior:/.match(description['value']).present?
          return description['value'].partition('Exterior: ').last
        end
      end
      'Nenhum'
    end

    def sticker?(skin)
      skin['descriptions'].each do |description|
        if /sticker_info/.match(description['value']).present?
          return true
        end
      end
      false
    end

    def name_sticker(skin)
      skin['descriptions'].each do |description|
        if /sticker_info/.match(description['value']).present?
          return description['value'].partition('><br>').last.sub('</center></div>', '').sub('Sticker', '')
        end
      end
      []
    end

    def image_sticker(skin)
      skin['descriptions'].each do |description|
        if /sticker_info/.match(description['value']).present?
          return description['value'].scan(/https?:\/\/[\S]+?png/)
        end
      end
      []
    end

    def stattrak?(skin)
      skin['descriptions'].each do |description|
        if /StatTrak/.match(description['value']).present?
          return true
        end
      end
      false
    end

    def price_steam(name)
      sleep(5)
      new_name = URI::escape(name)
      url = "https://steamcommunity.com/market/priceoverview/?currency=7&appid=730&market_hash_name=#{new_name}"
      resp = RestClient.get(url)

      JSON.parse(resp.body)['lowest_price'].nil? ? 0 : JSON.parse(resp.body)['lowest_price'].scan(/[,0-9]/).join.sub(',', '.').to_f
    end

    def inspect_skin(assetid, url)
      steam_id = @steam_account.steam_id
      url_fixed = 'https://api.csgofloat.com/?url=steam://rungame/730/76561202255233023/+csgo_econ_action_preview%20S'
      url_with_steamid_and_assetid = "#{steam_id}A#{assetid}"
      number_after_assetid = 'D' + url.partition('%D').last
      mount_url = url_fixed + url_with_steamid_and_assetid + number_after_assetid
      resp = RestClient.get(mount_url.to_s)

      JSON.parse(resp.body)['iteminfo']['floatvalue']
    end

    def assetid(ids, class_id)
      ids.each do |id|
        return id.second['id'] if id.second['classid'] == class_id
      end
      false
    end

    def inspect_in_game(assetid, url)
      steam_id = @steam_account.steam_id
      url_fixed = 'steam://rungame/730/76561202255233023/+csgo_econ_action_preview%20S'
      url_with_steamid_and_assetid = "#{steam_id}A#{assetid}"
      number_after_assetid = 'D' + url.partition('%D').last
      mount_url = url_fixed + url_with_steamid_and_assetid + number_after_assetid
    end

    def description_name_tag(name_tag)
      name_tag.to_s.partition("Name Tag: ''").last.sub("''\"]", '')
    end
  end
end
