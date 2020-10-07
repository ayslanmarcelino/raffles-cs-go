# frozen_string_literal: true

module Admins
  class ItemTypesController < UsersController
    def index
      @item_types = ItemType.all.order(:description)
    end

    def new
      @item_type = ItemType.new
    end

    def create
      @item_type = ItemType.new(params_item_type)

      @item_type.save ? (redirect_to admins_item_types_path, notice: 'Tipo de item cadastrado com sucesso') : (render :new)
    end

    private

    def params_item_type
      params.require(:item_type).permit(:description)
    end
  end
end
