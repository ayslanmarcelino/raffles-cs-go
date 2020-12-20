# frozen_string_literal: true

module Admins
  class TransactionsController < AdminsController
    before_action :set_transaction, only: %w[edit update destroy]
    before_action :set_transaction_type, only: %w[new create edit]
    before_action :set_user, only: %w[new create edit]
    rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

    def index
      @transactions = Transaction.where(user_id: current_user.id)
                                 .order(created_at: :desc)
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
      params.require(:transaction).permit(:description, :price, :transaction_type_id, :user_id)
    end
    
    def set_user
      @user = User.where(id: current_user.id)
    end

    def invalid_foreign_key
      redirect_to admins_transactions_index_path, notice: 'Não é possível excluir, pois a transação contém skins vinculadas.'
    end
  end
end
