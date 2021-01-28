# frozen_string_literal: true

class OwnersController < UsersController
  before_action :owner?

  private

  def owner?
    redirect_to root_path, notice: 'Você não tem permissão para acessar esta página' if current_user.is_owner == false && current_user.is_super_admin == false
  end
end
