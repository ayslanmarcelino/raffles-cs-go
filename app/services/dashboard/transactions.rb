# frozen_string_literal: true

module Dashboard
  class Transactions
    def initialize(transaction_info)
      @transaction_info = transaction_info
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
        profit: info[:profit]
      }
    end

    def info
      {
        transactions: list_transactions,
        total_value: value_transactions,
        price_paid: total_price_paid,
        profit: profit
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

    def list_transactions
      Transaction.all
    end
  end
end
