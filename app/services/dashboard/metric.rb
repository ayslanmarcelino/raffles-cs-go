
module Dashboard
  class Metric
    def initialize(metric_info)
      @metric_info = metric_info
    end

    def call
      metric_information
    end

    private

    def metric_information
      {
        users: info[:users],
        skins_available: info[:skins_available]
      }
    end

    def info
      {
        users: list_users,
        skins_available: list_skins_available
      }
    end

    def list_users
      User.all
    end

    def list_skins_available
      Skin.all.where('is_available = true')
    end
  end
end
