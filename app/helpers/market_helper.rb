# frozen_string_literal: true

module MarketHelper
  def sale_percentage(sale_price, price_steam)
    (100 - (sale_price * 100 / price_steam)).round(1)
  end
end
