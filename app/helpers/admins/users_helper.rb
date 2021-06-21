# frozen_string_literal: true

module Admins
  module UsersHelper
    def full_name_formatted(admin)
      full_name = "#{admin.first_name} #{admin.last_name}"
      humanize_full_name = full_name.humanize

      humanize_full_name.split.map { |x| x[0].upcase + x[1..] }.join(' ')
    end

    def admin_color?(admin)
      admin ? 'success' : 'primary'
    end

    def admin?(admin)
      admin ? t('admins.users.index.admin') : t('admins.users.index.user')
    end

    def last_sign_in_user(date)
      date.present? ? l(date, format: :with_full_hour) : t('admins.users.index.no_access')
    end
  end
end
