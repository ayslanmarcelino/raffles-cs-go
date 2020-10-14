module Admins
  class SkinsController < AdminsController
    before_action :set_skin, only: %w[show edit update destroy]

    def index
      @skins = Skin.all.order(price_steam: :desc)
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
      search_skins
    end

    def refresh_skins
      update_skins
    end

    private

    def set_skin
      @skin = Skin.find(params[:id])
    end

    def params_skin
      params.require(:skin).permit(:description, :float, :price_steam,
                                   :price_csmoney, :price_paid, :sale_price,
                                   :is_stattrak, :has_sticker, :is_available)
    end

    def search_skins
      requisition_api

      @skins_api.each do |skin|
        inspect_url = skin['actions'].first['link'] if skin['actions'].present?
        assetid = assetid(@rg_inventory, skin['classid'])
        exists_skin = Skin.find_by(id_steam: assetid)

        sleep(15)

        next if exists_skin
        next if skin['name'].include?('Case')
        next if skin['name'].include?('Graffiti')
        next if skin['name'].include?('Medal')

        sleep(15)

        skin_model = Skin.new
        skin_model.id_steam = assetid
        skin_model.description = skin['name']
        skin_model.description_color = skin['name_color']
        skin_model.exterior = skin['descriptions'].present? ? exterior(skin) : 'Nenhum'
        skin_model.image_skin = skin['actions'].present? ? image_skin(assetid, inspect_url) : ''
        skin_model.float = skin['actions'].present? ? inspect_skin(assetid, inspect_url) : 0
        skin_model.price_steam = price_steam(skin['market_name']).scan(/[,0-9]/).join().sub(',', '.').to_f
        skin_model.first_price_steam = price_steam(skin['market_name']).scan(/[,0-9]/).join().sub(',', '.').to_f
        skin_model.has_sticker = sticker?(skin)
        skin_model.is_stattrak = stattrak?(skin)
        skin_model.save
      end
    end

    def update_skins
      requisition_api

      @skins_api.each do |skin|
        assetid = assetid(@rg_inventory, skin['classid'])
        exists_skin = Skin.find_by(id_steam: assetid)
        sleep(10)

        if exists_skin
          exists_skin.price_steam = price_steam(skin['market_name']).scan(/[,0-9]/).join().sub(',', '.').to_f
          exists_skin.has_sticker = sticker?(skin)
          exists_skin.save
          next
        end
      end
    end

    def requisition_api
      url = 'https://steamcommunity.com/id/ayslanmarcelino/inventory/json/730/2'
      resp = RestClient.get(url)
      @rg_inventory = JSON.parse(resp.body)['rgInventory']
      @skins_api = JSON.parse(resp.body)['rgDescriptions'].values
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

    def stattrak?(skin)
      skin['descriptions'].each do |description|
        if /StatTrak/.match(description['value']).present?
          return true
        end
      end
      false
    end

    def price_steam(name)
      name.include?('™') ? new_name = name.sub('™', '%E2%84%A2') : new_name = name.sub('★', '%E2%98%85')
      url = "https://steamcommunity.com/market/priceoverview/?currency=7&appid=730&market_hash_name=#{new_name}"
      resp = RestClient.get(url)

      JSON.parse(resp.body)['lowest_price']
    end

    def inspect_skin(assetid, url)
      steam_id = 76_561_198_345_749_032
      url_fixed = 'https://api.csgofloat.com/?url=steam://rungame/730/76561202255233023/+csgo_econ_action_preview%20S'
      url_with_steamid_and_assetid = "#{steam_id}A#{assetid}"
      number_after_assetid = 'D' + url.partition('%D').last
      mount_url = url_fixed + url_with_steamid_and_assetid + number_after_assetid
      resp = RestClient.get(mount_url.to_s)

      JSON.parse(resp.body)['iteminfo']['floatvalue']
    end

    def image_skin(assetid, url)
      steam_id = 76_561_198_345_749_032
      url_fixed = 'https://api.csgofloat.com/?url=steam://rungame/730/76561202255233023/+csgo_econ_action_preview%20S'
      url_with_steamid_and_assetid = "#{steam_id}A#{assetid}"
      number_after_assetid = 'D' + url.partition('%D').last
      mount_url = url_fixed + url_with_steamid_and_assetid + number_after_assetid
      resp = RestClient.get(mount_url.to_s)

      JSON.parse(resp.body)['iteminfo']['imageurl']
    end

    def assetid(ids, class_id)
      ids.each do |id|
        return id.second['id'] if id.second['classid'] == class_id
      end
      false
    end
  end
end
