# frozen_string_literal: true

class AdminsController < UsersController
  before_action :admin?

  private

  def admin?
    redirect_to root_path, notice: 'Você não tem permissão para acessar esta página' if current_user.is_admin == false && current_user.is_super_admin == false
  end
end
