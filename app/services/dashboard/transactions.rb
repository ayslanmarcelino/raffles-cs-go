# frozen_string_literal: true

module Dashboard
  class Transactions
    def initialize(transaction_info, current_user)
      @transaction_info = transaction_info
      @current_user = current_user
    end

    def call
      transaction_information
    end

    private

    def transaction_information
      {
        transactions: info[:transactions],
        value: info[:total_value],
        price_paid: info[:price_paid],
        profit: info[:profit],
        transactions_by_month_keys: info[:transactions_keys],
        transactions_by_month_values: info[:transactions_values],
        transactions_by_type_keys: info[:transactions_by_type_keys],
        transactions_by_type_values: info[:transactions_by_type_values],
        net_profit_keys: info[:net_profit_keys],
        net_profit_values: info[:net_profit_values]
      }
    end

    def info
      {
        transactions: list_transactions,
        total_value: value_transactions,
        price_paid: total_price_paid,
        profit: profit,
        transactions_keys: transactions_by_month_keys,
        transactions_values: transactions_by_month_values,
        transactions_by_type_keys: transactions_by_type_keys,
        transactions_by_type_values: transactions_by_type_values,
        net_profit_keys: net_profit_keys,
        net_profit_values: net_profit_values
      }
    end

    def profit
      value_transactions - total_price_paid
    end

    def total_price_paid
      price_paid = 0
      list_transactions.each do |transaction|
        transaction.skins.each do |skin|
          skin.price_paid
          price_paid += skin.price_paid
        end
      end
      price_paid
    end

    def value_transactions
      list_transactions.sum(&:price)
    end

    def transactions_by_month_keys
      transactions_by_month.keys
    end

    def transactions_by_month_values
      transactions_by_month.values
    end

    def transactions_by_type_keys
      transactions_by_type.map { |k, _| k.description.capitalize }
    end

    def transactions_by_type_values
      transactions_by_type.values
    end

    def transactions_by_type
      
      binding.pry
      
      list_transactions.where('created_at > ? AND created_at < ?', Time.now.beginning_of_month, Time.now.end_of_month)
                       .group(:transaction_type)
                       .sum(:price)
    end

    def transactions_by_month
      transactions_values_by_month.merge(skins_price_paid_by_month) { |_, transactions, price_paid| transactions - price_paid }
    end

    def net_profit_keys
      net_profit.keys
    end

    def net_profit_values
      net_profit.values
    end

    def net_profit
      transactions_values_by_month.merge(skins_purchased_per_month) do |_, transactions, price_paid|
        transactions - price_paid
      end
    end

    def transactions_values_by_month
      list_transactions.group_by_month(:created_at, format: '%b/%Y')
                       .sum(:price)
    end

    def skins_price_paid_by_month
      list_transactions.joins(:skins)
                       .group_by_month(:created_at, format: '%b/%Y')
                       .sum(:price_paid)
    end

    def skins_purchased_per_month
      list_skins.group_by_month(:created_at, format: '%b/%Y')
                .sum(:price_paid)
    end

    def list_transactions
      Transaction.where(user_id: @current_user.id)
                 .where('extract(year from transactions.created_at) = ?', Date.current.year)
    end

    def list_skins
      Skin.includes(:steam_account)
          .joins(:steam_account)
          .where("steam_accounts.user_id = #{@current_user.id}")
          .where(ignore_financial: false)
          .where('extract(year from skins.created_at) = ?', Date.current.year)
    end
  end
end
