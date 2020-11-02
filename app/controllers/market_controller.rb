class MarketController < UsersController
  helper_method :sort_column, :sort_direction

  def index
    skin_available_to_sale
  end

  private

  def skin_available_to_sale
    @skins = Skin.where(is_available: true)
                 .where('price_steam > price_paid')
                 .where('price_steam > sale_price')
                 .where('sale_price > 0')
                 .order(sort_column + ' ' + sort_direction)
  end

  def sort_column
    Skin.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end
end
