# frozen_string_literal: true

module MarketHelper
  def sale_percentage(sale_price, price_steam)
    (100 - (sale_price * 100 / price_steam)).round(1)
  end

  def type_weapon_collection
    Skin.pluck(:type_weapon)
        .sort
        .uniq
  end

  def type_skin_collection
    Skin.pluck(:type_skin)
        .sort
        .uniq
  end

  def exterior_collection
    Skin.pluck(:exterior)
        .sort
        .uniq
  end
end
