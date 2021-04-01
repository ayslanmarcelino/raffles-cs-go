# frozen_string_literal: true

namespace :translate_type_skin do
  desc 'Translate type skin'
  task update: :environment do
    Skin.where('type_skin LIKE ?', '%Pistol%').find_each do |t|
      t.update(type_skin: t.type_skin.gsub('Pistola', 'Pistola'))
    end

    Skin.where('type_skin LIKE ?', '%Graffiti%').find_each do |t|
      t.update(type_skin: t.type_skin.gsub('Graffiti', 'Grafite'))
    end

    Skin.where('type_skin LIKE ?', '%SMG%').find_each do |t|
      t.update(type_skin: t.type_skin.gsub('SMG', 'Submetralhadora'))
    end

    Skin.where('type_skin LIKE ?', '%Sticker%').find_each do |t|
      t.update(type_skin: t.type_skin.gsub('Sticker', 'Adesivo'))
    end

    Skin.where('type_skin LIKE ?', '%Shotgun%').find_each do |t|
      t.update(type_skin: t.type_skin.gsub('Shotgun', 'Escopeta'))
    end

    Skin.where('type_skin LIKE ?', '%Sniper Rifle%').find_each do |t|
      t.update(type_skin: t.type_skin.gsub('Sniper Rifle', 'Rifle de Precisão'))
    end

    Skin.where('type_skin LIKE ?', '%Agent%').find_each do |t|
      t.update(type_skin: t.type_skin.gsub('Agent', 'Agente'))
    end

    Skin.where('type_skin LIKE ?', '%Knife%').find_each do |t|
      t.update(type_skin: t.type_skin.gsub('Knife', 'Faca'))
    end

    Skin.where('type_skin LIKE ?', '%Machinegun%').find_each do |t|
      t.update(type_skin: t.type_skin.gsub('Machinegun', 'Metralhadora'))
    end

    Skin.where('type_skin LIKE ?', '%Music Kit%').find_each do |t|
      t.update(type_skin: t.type_skin.gsub('Music Kit', 'Trilha Sonora'))
    end

    Skin.where('type_skin LIKE ?', '%Gloves%').find_each do |t|
      t.update(type_skin: t.type_skin.gsub('Gloves', 'Luvas'))
    end
  end
end
