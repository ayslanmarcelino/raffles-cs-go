class NewMarketController < ApplicationController
  def index
    skin_available_to_sale
  end

  private

  def skin_available_to_sale
    @q = Skin.includes(:steam_account)
             .where(is_available: true)
             .where('price_steam > price_paid OR price_csmoney > price_paid')
             .where('price_steam > sale_price OR price_csmoney > sale_price')
             .where('sale_price > 0')
             .page(params[:page])
             .ransack(params[:q])
    @skins = @q.result(distinct: true)
  end
end
