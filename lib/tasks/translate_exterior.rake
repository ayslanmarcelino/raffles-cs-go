# frozen_string_literal: true

namespace :translate_exterior do
  desc 'Translate skins exterior'
  task update: :environment do
    Skin.where('exterior LIKE ?', '%Battle-Scarred%').find_each do |t|
      t.update(exterior: t.exterior.gsub('Battle-Scarred', 'Veterana de Guerra'))
    end

    Skin.where('exterior LIKE ?', '%Minimal Wear%').find_each do |t|
      t.update(exterior: t.exterior.gsub('Minimal Wear', 'Pouco Usada'))
    end

    Skin.where('exterior LIKE ?', '%Field-Tested%').find_each do |t|
      t.update(exterior: t.exterior.gsub('Field-Tested', 'Testada em Campo'))
    end

    Skin.where('exterior LIKE ?', '%Well-Worn%').find_each do |t|
      t.update(exterior: t.exterior.gsub('Well-Worn', 'Bem Desgastada'))
    end

    Skin.where('exterior LIKE ?', '%Factory New%').find_each do |t|
      t.update(exterior: t.exterior.gsub('Factory New', 'Nova de Fábrica'))
    end
  end
end
