# frozen_string_literal: true

module Admins
  class DashboardController < AdminsController
    before_action :metrics_service, only: %i[index]
    before_action :metrics_financial, only: %i[index]
    before_action :metrics_transaction, only: %i[index]

    def index; end

    private

    def metrics_service
      @metric_info = Dashboard::Metric.new(@metric_info, current_user).call
    end

    def metrics_financial
      @financial_info = Dashboard::Financial.new(@financial_info, current_user).call
    end

    def metrics_transaction
      @transaction_info = Dashboard::Transactions.new(@transaction_info, current_user).call
    end
  end
end
