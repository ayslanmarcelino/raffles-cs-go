# frozen_string_literal: true

module Admins
  class AvailableSkinsController < AdminsController
    def index
      @q = Skin.joins(:steam_account)
               .where("steam_accounts.user_id = #{current_user.id}")
               .where(is_available: true)
               .where('expiration_date < ? OR expiration_date is null', DateTime.now)
               .page(params[:page])
               .ransack(params[:q])
      @skins = @q.result(distinct: true)
      @available_skins = Skin.where(is_available: true)
    end
  end
end
