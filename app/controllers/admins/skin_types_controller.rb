# frozen_string_literal: true

module Admins
  class SkinTypesController < AdminsController
    before_action :set_item_type, only: %w[new create edit]
    before_action :set_skin_type, only: %w[edit update destroy]

    def index
      @skin_types = SkinType.all.order(:description).page(params[:page])
    end

    def new
      @skin_type = SkinType.new
    end

    def create
      @skin_type = SkinType.new(params_skin_type)

      @skin_type.save ? (redirect_to admins_skin_types_path, notice: 'Tipo de skin cadastrado com sucesso') : (render :new)
    end

    def edit; end

    def update
      @skin_type.update(params_skin_type) ? (redirect_to admins_skin_types_path, notice: 'Tipo de skin atualizado com sucesso') : (render :edit)
    end

    def destroy
      @skin_type.destroy ? (redirect_to admins_skin_types_path, notice: 'Tipo de skin excluído com sucesso') : (render :index)
    end

    private

    def set_item_type
      @item_types = ItemType.all.order(:description)
    end

    def set_skin_type
      @skin_type = SkinType.find(params[:id])
    end

    def params_skin_type
      params.require(:skin_type).permit(:description, :item_type_id)
    end
  end
end
