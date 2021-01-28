# frozen_string_literal: true

module SuperAdmins
  class EnterprisesController < SuperAdminsController
    before_action :set_enterprise, only: %w[edit update destroy]
    rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

    def index
      @enterprises = Enterprise.all.order(:description)
    end

    def new
      @enterprise = Enterprise.new
    end

    def create
      @enterprise = Enterprise.new(params_enterprise)

      @enterprise.save ? (redirect_to super_admins_enterprises_path, notice: 'Empresa cadastrada com sucesso') : (render :new)
    end

    def edit; end

    def update
      @enterprise.update(params_enterprise) ? (redirect_to super_admins_enterprises_path, notice: 'Empresa atualizada com sucesso') : (render :edit)
    end

    def destroy
      @enterprise.destroy ? (redirect_to super_admins_enterprises_path, notice: 'Empresa excluída com sucesso') : (render :index)
    end

    private

    def set_enterprise
      @enterprise = Enterprise.find(params[:id])
    end

    def params_enterprise
      params.require(:enterprise).permit(:description, :instagram, :twitch, :whatsapp_group, :primary_color, :secondary_color, :logo, :favicon)
    end

    def invalid_foreign_key
      redirect_to super_admins_enterprises_path, notice: 'Não é possível excluir, pois há usuários vinculados.'
    end
  end
end
  