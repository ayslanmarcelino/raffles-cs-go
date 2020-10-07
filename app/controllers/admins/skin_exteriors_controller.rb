# frozen_string_literal: true

module Admins
  class SkinExteriorsController < AdminsController
    before_action :set_skin_exterior, only: %w[edit update destroy]

    def index
      @skin_exteriors = SkinExterior.all.order(:description).page(params[:page])
    end

    def new
      @skin_exterior = SkinExterior.new
    end

    def create
      @skin_exterior = SkinExterior.new(params_skin_exterior)

      @skin_exterior.save ? (redirect_to admins_skin_exteriors_path, notice: 'Exterior de skin cadastrado com sucesso') : (render :new)
    end

    def edit; end

    def update
      @skin_exterior.update(params_skin_exterior) ? (redirect_to admins_skin_exteriors_path, notice: 'Exterior de skin atualizado com sucesso') : (render :edit)
    end

    def destroy
      @skin_exterior.destroy ? (redirect_to admins_skin_exteriors_path, notice: 'Exterior de skin excluído com sucesso') : (render :index)
    end

    private

    def set_skin_exterior
      @skin_exterior = SkinExterior.find(params[:id])
    end

    def params_skin_exterior
      params.require(:skin_exterior).permit(:description, :item_type_id)
    end
  end
end
