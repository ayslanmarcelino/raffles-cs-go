class MarketController < UsersController
  def index
    skin_available_to_sale
  end

  private

  def skin_available_to_sale
    steam_accounts = current_user.enterprise.user.map(&:steam_account)
    @steam_account_ids = ''
    steam_accounts.each do |steam_account|
      @steam_account_ids << steam_account.ids.join(', ')
    end

    @q = Skin.includes(:steam_account)
             .where({ steam_account_id: @steam_account_ids })
             .where(is_available: true)
             .where('price_steam > price_paid OR price_csmoney > price_paid')
             .where('price_steam > sale_price OR price_csmoney > sale_price')
             .where('sale_price > 0')
             .page(params[:page])
             .ransack(params[:q])
    @skins = @q.result(distinct: true)
  end
end
