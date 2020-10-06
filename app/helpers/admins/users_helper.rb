module Admins
  module UsersHelper
    def admin_color?(admin)
      admin == true ? 'success' : 'primary'
    end

    def admin?(admin)
      admin ? t('admins.users.index.admin') : t('admins.users.index.user')
    end

    def last_sign_in_user(date)
      date.present? ? l(date, format: :with_full_hour) : t('admins.users.index.no_access')
    end
  end
end
