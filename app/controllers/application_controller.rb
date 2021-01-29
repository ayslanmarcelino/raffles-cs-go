# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :active?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def active?
    if current_user.present? && !current_user.is_active?
      sign_out(current_user)
      flash[:danger] = 'Sua conta está inativa. Para mais informações, entre em contato com o administrador da empresa.'
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name nickname ddi cell_phone is_whatsapp])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name nickname ddi cell_phone is_whatsapp])
  end
end
