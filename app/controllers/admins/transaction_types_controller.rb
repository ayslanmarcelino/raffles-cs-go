# frozen_string_literal: true

module Admins
  class TransactionTypesController < AdminsController
    before_action :set_transaction_type, only: %w[edit update destroy]
    rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

    def index
      @transaction_types = TransactionType.where(user_id: current_user.id)
                                          .order(:description)
    end

    def new
      @transaction_type = TransactionType.new
    end

    def create
      @transaction_type = TransactionType.new(params_transaction_type)

      @transaction_type.save ? (redirect_to admins_transaction_types_path, notice: 'Tipo de transação cadastrado com sucesso') : (render :new)
    end

    def edit; end

    def update
      @transaction_type.update(params_transaction_type) ? (redirect_to admins_transaction_types_path, notice: 'Tipo de transação atualizado com sucesso') : (render :edit)
    end

    def destroy
      @transaction_type.destroy ? (redirect_to admins_transaction_types_path, notice: 'Tipo de transação excluído com sucesso') : (render :index)
    end

    private

    def set_transaction_type
      if current_user.transaction_type_ids.include?(TransactionType.find(params[:id]).id)
        @transaction_type = TransactionType.find(params[:id])
      else
        redirect_to root_path, notice: 'Você não tem permissão para manipular este tipo de transação.'
      end
    end

    def params_transaction_type
      params.require(:transaction_type).permit(:description)
    end

    def invalid_foreign_key
      redirect_to admins_transaction_types_path, notice: 'Não é possível excluir, pois tipo de transaçāo contém transaçāo vinculadas.'
    end
  end
end
