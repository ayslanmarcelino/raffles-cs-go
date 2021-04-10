class MarketController < ApplicationController
  before_action :skin_available_to_sale, only: %i[index show]
  before_action :set_skin, only: %i[show]

  private

  def skin_available_to_sale
    @q = Skin.where(is_available: true)
             .where('price_steam > price_paid OR price_csmoney > price_paid')
             .where('price_steam > sale_price OR price_csmoney > sale_price')
             .where('sale_price > 0')
             .page(params[:page])
             .ransack(params[:q])
    @skins = @q.result(distinct: true)
  end

  def set_skin
    @skin = Skin.find(params[:id])
  end
end
