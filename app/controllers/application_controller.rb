# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :skin_available_to_sale, if: :devise_controller?
  skip_before_action :verify_authenticity_token

  layout 'application'

  def skin_available_to_sale
    @q = Skin.where(is_available: true)
             .where('price_steam > price_paid OR price_csmoney > price_paid')
             .where('price_steam > sale_price OR price_csmoney > sale_price')
             .where('sale_price > 0')
             .page(params[:page])
             .ransack(params[:q])
    @skins = @q.result(distinct: true)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name nickname ddi cell_phone is_whatsapp])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name nickname ddi cell_phone is_whatsapp])
  end
end
