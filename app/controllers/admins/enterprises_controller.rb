# frozen_string_literal: true

module Admins
  class EnterprisesController < AdminsController
    before_action :set_enterprise, only: %w[edit update]

    def edit; end

    def update
      @enterprise.update(params_enterprise) ? (redirect_to admins_dashboard_index_path, notice: 'Empresa atualizada com sucesso') : (render :edit)
    end

    private

    def set_enterprise
      if current_user.enterprise.id == params[:id].to_i
        @enterprise = Enterprise.find(params[:id])
      else
        redirect_to root_path, notice: 'Você não tem permissão para manipular esta empresa.'
      end
    end

    def params_enterprise
      params.require(:enterprise).permit(:description, :instagram, :twitch, :whatsapp_group, :primary_color, :secondary_color, :logo, :favicon)
    end
  end
end
