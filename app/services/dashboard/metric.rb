# frozen_string_literal: true

module Dashboard
  class Metric
    def initialize(metric_info, current_user)
      @metric_info = metric_info
      @current_user = current_user
    end

    def call
      metric_information
    end

    private

    def metric_information
      {
        users: info[:users],
        skins_available: info[:skins_available],
        without_tradelock: info[:without_tradelock],
        with_tradelock: info[:with_tradelock]
      }
    end

    def info
      {
        users: list_users,
        skins_available: list_skins_available,
        without_tradelock: list_skins_without_tradelock,
        with_tradelock: list_skins_tradelock
      }
    end

    def list_users
      User.all
    end

    def list_skins_available
      Skin.joins(:steam_account)
          .where("steam_accounts.user_id = #{@current_user.id}")
          .where(is_available: true)
    end

    def list_skins_without_tradelock
      Skin.joins(:steam_account)
          .where("steam_accounts.user_id = #{@current_user.id}")
          .where(is_available: true)
          .where('expiration_date < ? OR expiration_date is null', Time.now)
    end

    def list_skins_tradelock
      Skin.joins(:steam_account)
          .where("steam_accounts.user_id = #{@current_user.id}")
          .where(is_available: true)
          .where('expiration_date > ?', Time.now)
    end
  end
end
