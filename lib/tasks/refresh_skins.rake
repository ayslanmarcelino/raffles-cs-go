# frozen_string_literal: true

namespace :refresh_skins do
  desc 'Refresh available skins'
  task refresh: :environment do
    skins = Admins::SkinsController.new
    skins.refresh_skins
  end
end
