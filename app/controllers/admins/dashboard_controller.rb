# frozen_string_literal: true

module Admins
  class DashboardController < AdminsController
    before_action :metrics_service, only: %i[index]
    before_action :metrics_financial, only: %i[index]

    def index; end

    private

    def metrics_service
      @metric_info = Dashboard::Metric.new(@metric_info).call
    end

    def metrics_financial
      @financial_info = Dashboard::Financial.new(@financial_info).call
    end
  end
end
