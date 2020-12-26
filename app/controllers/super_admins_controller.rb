# frozen_string_literal: true

class SuperAdminsController < UsersController
  before_action :super_admin?

  private

  def super_admin?
    redirect_to root_path, notice: 'Você não tem permissão para acessar esta página' if current_user.is_super_admin == false
  end
end
