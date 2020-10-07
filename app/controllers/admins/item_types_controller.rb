# frozen_string_literal: true

module Admins
  class ItemTypesController < AdminsController
    before_action :set_item_type, only: %w[edit update destroy]
    rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

    def index
      @item_types = ItemType.all.order(:description).page(params[:page])
    end

    def new
      @item_type = ItemType.new
    end

    def create
      @item_type = ItemType.new(params_item_type)

      @item_type.save ? (redirect_to admins_item_types_path, notice: 'Tipo de item cadastrado com sucesso') : (render :new)
    end

    def edit; end

    def update
      @item_type.update(params_item_type) ? (redirect_to admins_item_types_path, notice: 'Tipo de item atualizado com sucesso') : (render :edit)
    end

    def destroy
      @item_type.destroy ? (redirect_to admins_item_types_path, notice: 'Tipo de item excluído com sucesso') : (render :index)
    end

    private

    def invalid_foreign_key
      redirect_to admins_item_types_path, notice: 'Tipo de skin não pode ser excluída, pois há um tipo de item associado'
    end

    def set_item_type
      @item_type = ItemType.find(params[:id])
    end

    def params_item_type
      params.require(:item_type).permit(:description)
    end
  end
end
