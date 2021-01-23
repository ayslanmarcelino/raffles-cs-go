# frozen_string_literal: true

module Admins
  class SteamAccountsController < AdminsController
    before_action :set_steam_account, only: %w[edit update destroy]
    before_action :set_user, only: %w[new create edit]
    rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

    def index
      @steam_accounts = SteamAccount.where(user_id: current_user.id).order(created_at: :desc)
    end

    def new
      @steam_account = SteamAccount.new
    end

    def create
      @steam_account = SteamAccount.new(params_steam_account)

      @steam_account.save ? (redirect_to admins_steam_accounts_index_path, notice: 'Conta da Steam cadastrada com sucesso') : (render :new)
    end

    def edit; end

    def update
      @steam_account.update(params_steam_account) ? (redirect_to admins_steam_accounts_index_path, notice: 'Conta da Steam atualizada com sucesso') : (render :edit)
    end

    def destroy
      @steam_account.destroy ? (redirect_to admins_steam_accounts_index_path, notice: 'Conta da Steam excluída com sucesso') : (render :index)
    end

    private

    def set_steam_account
      @steam_account = SteamAccount.find(params[:id])
    end

    def set_user
      @user = User.where(id: current_user.id)
    end

    def params_steam_account
      params.require(:steam_account).permit(:description, :steam_id, :url, :user_id)
    end

    def invalid_foreign_key
      redirect_to admins_steam_accounts_index_path, notice: 'Não é possível excluir, pois a conta da Steam contém skins vinculadas.'
    end
  end
end