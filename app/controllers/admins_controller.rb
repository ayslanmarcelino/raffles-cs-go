# frozen_string_literal: true

class AdminsController < UsersController
  before_action :admin?

  private

  def admin?
    if current_user.is_admin == false && current_user.is_owner == false && current_user.is_super_admin == false
      redirect_to root_path, notice: 'Você não tem permissão para acessar esta página'
    end
  end
end
