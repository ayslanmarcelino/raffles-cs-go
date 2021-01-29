# frozen_string_literal: true

module SuperAdmins
  class UsersController < SuperAdminsController
    before_action :verify_password, only: %w[update]
    before_action :set_user, only: %w[edit update destroy]
  before_action :set_enterprise, only: %w[new edit update destroy]

    def index
      @users = User.order(:first_name)
    end

    def new
      @user = User.new
    end

    def show; end

    def create
      @user = User.new(params_user)

      @user.save ? (redirect_to super_admins_users_path, notice: 'Usuário cadastrado com sucesso') : (render :new)
    end

    def edit; end

    def update
      @user.update(params_user) ? (redirect_to super_admins_users_path, notice: 'Usuário atualizado com sucesso') : (render :edit)
    end

    def destroy
      @user.destroy ? (redirect_to super_admins_users_path, notice: 'Usuário excluído com sucesso') : (render :index)
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def set_enterprise
      @enterprise = Enterprise.order(:description)
    end

    def params_user
      params.require(:user)
            .permit(:first_name, :last_name, :nickname, :email, :ddi, :cell_phone, :is_whatsapp, :is_admin, :password,
                    :password_confirmation, :is_owner, :enterprise_id, :is_active, :is_super_admin)
    end

    def verify_password
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].extract!(:password, :password_confirmation)
      end
    end
  end
end
