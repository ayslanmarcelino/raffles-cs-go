# frozen_string_literal: true

module Admins
  class TransactionsController < AdminsController
    before_action :set_transaction, only: %w[edit update destroy]
    before_action :set_transaction_type, only: %w[new create edit]

    def index
      @transactions = Transaction.all.order(:description)
    end

    def new
      @transaction = Transaction.new
    end

    def create
      @transaction = Transaction.new(params_transaction)

      @transaction.save ? (redirect_to admins_transactions_index_path, notice: 'Transação cadastrada com sucesso') : (render :new)
    end

    def edit; end

    def update
      @transaction.update(params_transaction) ? (redirect_to admins_transactions_index_path, notice: 'Transação atualizada com sucesso') : (render :edit)
    end

    def destroy
      @transaction.destroy ? (redirect_to admins_transactions_index_path, notice: 'Transação excluída com sucesso') : (render :index)
    end

    private

    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def set_transaction_type
      @transaction_types = TransactionType.all.order(:description)
    end

    def params_transaction
      params.require(:transaction).permit(:description, :price, :transaction_type_id)
    end
  end
end
