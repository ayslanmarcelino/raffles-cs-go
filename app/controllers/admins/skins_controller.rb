module Admins
  class SkinsController < AdminsController
    before_action :set_item_type, only: %w[new create edit]
    before_action :set_skin_type, only: %w[new create edit]
    before_action :set_skin_exterior, only: %w[new create edit]
    before_action :set_transaction_type, only: %w[new create edit]
    before_action :set_skin, only: %w[show edit update destroy]

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

    def set_item_type
      @item_types = ItemType.all.order(:description)
    end

    def set_skin_type
      @skin_types = SkinType.all.order(:description)
    end

    def set_skin_exterior
      @skin_exteriors = SkinExterior.all.order(:description)
    end

    def set_transaction_type
      @transaction_types = TransactionType.all.order(:description)
    end

    def set_skin
      @skin = Skin.find(params[:id])
    end

    def params_skin
      params.require(:skin).permit(:description, :float, :price_steam, :price_csmoney, :price_paid, :sale_price,
                                   :is_stattrak, :has_sticker, :is_available, :item_type_id, :skin_type_id,
                                   :skin_exterior_id, :transaction_type_id, :image_skin)
    end
  end
end
