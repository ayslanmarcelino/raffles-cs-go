module Admins
  class DashboardController < AdminsController
    def index
      @dashboard = dashboard_information
    end

    private

    def dashboard_information
      {
        users: info[:users],
        skins_available: info[:skins_available],
        price_total_steam: info[:price_total_steam],
        price_total_csmoney: info[:price_total_csmoney],
        price_total_paid: info[:price_total_paid],
        difference_value: info[:difference_value]
      }
    end

    def info
      {
        users: list_users,
        skins_available: list_skins_available,
        price_total_steam: total_inventory_steam,
        price_total_csmoney: total_inventory_csmoney,
        price_total_paid: total_inventory_paid,
        difference_value: total_difference_value
      }
    end

    def list_users
      User.all
    end

    def list_skins_available
      Skin.all.where('is_available = true')
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
