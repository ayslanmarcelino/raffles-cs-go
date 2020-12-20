# frozen_string_literal: true

module Dashboard
  class Financial
    def initialize(financial_info, current_user)
      @financial_info = financial_info
      @current_user = current_user
    end

    def call
      financial_information
    end

    private

    def financial_information
      {
        price_total_steam: info[:price_total_steam],
        price_total_csmoney: info[:price_total_csmoney],
        price_total_paid: info[:price_total_paid],
        difference_value: info[:difference_value]
      }
    end

    def info
      {
        price_total_steam: total_inventory_steam,
        price_total_csmoney: total_inventory_csmoney,
        price_total_paid: total_inventory_paid,
        difference_value: total_difference_value
      }
    end

    def list_skins_available
      Skin.all
          .joins(:steam_account)
          .where("steam_accounts.user_id = #{@current_user.id}")
          .where(is_available: true)
    end

    def total_inventory_steam
      list_skins_available.map(&:price_steam).sum
    end

    def total_inventory_csmoney
      list_skins_available.map(&:price_csmoney).sum
    end

    def total_inventory_paid
      list_skins_available.map(&:price_paid).sum
    end

    def total_difference_value
      total_inventory_steam - total_inventory_paid
    end
  end
end
