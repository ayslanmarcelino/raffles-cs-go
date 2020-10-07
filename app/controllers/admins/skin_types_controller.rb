# frozen_string_literal: true

module Admins
  class SkinTypesController < AdminsController
    def index
      @skin_types = SkinType.all.order(:description).page(params[:page])
    end

    def edit; end

    def update; end

    def destroy; end
  end
end
