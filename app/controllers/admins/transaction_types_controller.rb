# frozen_string_literal: true

module Admins
  class TransactionTypesController < AdminsController
    before_action :set_item_type, only: %w[new create edit]
    before_action :set_transaction_type, only: %w[edit update destroy]

    def index
      @transaction_types = TransactionType.all.order(:description).page(params[:page])
    end

    def new
      @transaction_type = TransactionType.new
    end

    def create
      @transaction_type = TransactionType.new(params_transaction_type)

      @transaction_type.save ? (redirect_to admins_transaction_types_path, notice: 'Tipo de skin cadastrado com sucesso') : (render :new)
    end

    def edit; end

    def update
      @transaction_type.update(params_transaction_type) ? (redirect_to admins_transaction_types_path, notice: 'Tipo de skin atualizado com sucesso') : (render :edit)
    end

    def destroy
      @transaction_type.destroy ? (redirect_to admins_transaction_types_path, notice: 'Tipo de skin excluído com sucesso') : (render :index)
    end

    private

    def set_item_type
      @item_types = ItemType.all.order(:description)
    end

    def set_transaction_type
      @transaction_type = TransactionType.find(params[:id])
    end

    def params_transaction_type
      params.require(:transaction_type).permit(:description, :item_type_id)
    end
  end
end
