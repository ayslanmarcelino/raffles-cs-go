# frozen_string_literal: true

module Admins
  module UsersHelper
    def full_name_formatted(admin)
      full_name = "#{admin.first_name} #{admin.last_name}"
      humanize_full_name = full_name.humanize

      humanize_full_name.split.map { |x| x[0].upcase + x[1..-1] }.join(' ')
    end

    def role_color?(admin, super_admin, owner)
      return 'dark' if super_admin
      return 'secondary' if owner
      return 'success' if admin
      return 'primary' if !admin && !super_admin
    end

    def role?(admin, super_admin, owner)
      return t('owners.users.index.super_admin') if super_admin
      return t('owners.users.index.owner') if owner
      return t('owners.users.index.admin') if admin
      return t('owners.users.index.user') if !owner && !admin && !super_admin
    end

    def last_sign_in_user(date)
      date.present? ? l(date, format: :with_full_hour) : t('owners.users.index.no_access')
    end
  end
end
