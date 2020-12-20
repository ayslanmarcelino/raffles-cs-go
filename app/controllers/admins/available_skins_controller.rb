# frozen_string_literal: true

module Admins
  class AvailableSkinsController < AdminsController
    before_action :set_skin, only: %w[show edit update destroy]
    helper_method :sort_column, :sort_direction

    def index
      @skins = Skin.all
                   .joins(:steam_account)
                   .where("steam_accounts.user_id = #{current_user.id}")
                   .order(sort_column + ' ' + sort_direction)
                   .where(is_available: true)
                   .where('expiration_date < ? OR expiration_date is null', DateTime.now)                   
    end

    private

    def sort_column
      Skin.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end
  end
end
  