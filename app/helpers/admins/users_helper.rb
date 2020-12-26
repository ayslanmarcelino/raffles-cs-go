# frozen_string_literal: true

module Admins
  module UsersHelper
    def full_name_formatted(admin)
      full_name = "#{admin.first_name} #{admin.last_name}"
      humanize_full_name = full_name.humanize

      humanize_full_name.split.map { |x| x[0].upcase + x[1..-1] }.join(' ')
    end

    def admin_color?(admin, super_admin)
      return 'primary' if !admin && !super_admin
      return 'success' if admin && !super_admin
      return 'dark' if super_admin
    end

    def admin?(admin, super_admin)
      return t('admins.users.index.user') if !admin && !super_admin
      return t('admins.users.index.admin') if admin && !super_admin
      return t('admins.users.index.super_admin') if super_admin
    end

    def last_sign_in_user(date)
      date.present? ? l(date, format: :with_full_hour) : t('admins.users.index.no_access')
    end
  end
end
