module Admins
  class SkinsController < AdminsController
    before_action :set_skin, only: %w[edit update destroy]

    def index
      @skins = Skin.all.order(:description).page(params[:page])
    end

    def new
      @skin = Skin.new
    end

    def create
      @skin = Skin.new(params_skin)

      @skin.save ? (redirect_to admins_skins_path, notice: 'Skin cadastrada com sucesso') : (render :new)
    end

    def edit; end

    def update
      @skin.update(params_skin) ? (redirect_to admins_skins_path, notice: 'Skin atualizada com sucesso') : (render :edit)
    end

    def destroy
      @skin.destroy ? (redirect_to admins_skins_path, notice: 'Skin excluída com sucesso') : (render :index)
    end

    private

    def set_skin
      @skin = Skin.find(params[:id])
    end

    def params_skin
      params.require(:skin).permit(:description, :item_type_id)
    end
  end
end
