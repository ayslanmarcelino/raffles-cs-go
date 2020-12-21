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
        transactions_by_month_values: info[:transactions_values]
      }
    end

    def info
      {
        transactions: list_transactions,
        total_value: value_transactions,
        price_paid: total_price_paid,
        profit: profit,
        transactions_keys: transactions_by_month_keys,
        transactions_values: transactions_by_month_values
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

    def transactions_by_month
      list_transactions.where('created_at > ? AND created_at < ?', Time.now.beginning_of_year, Time.now.end_of_year)
                       .group_by_month(:created_at, format: "%b/%Y")
                       .sum(:price)
    end

    def list_transactions
      Transaction.all
                 .where(user_id: @current_user.id)
    end
  end
end
