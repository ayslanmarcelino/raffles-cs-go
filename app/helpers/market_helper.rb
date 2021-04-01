# frozen_string_literal: true

module MarketHelper
  def sale_percentage(sale_price, price_steam)
    (100 - (sale_price * 100 / price_steam)).round(1)
  end

  def type_weapon_collection
    Skin.pluck(:type_weapon)
        .compact
        .sort
        .uniq
  end

  def type_skin_collection
    Skin.pluck(:type_skin)
        .compact
        .sort
        .uniq
  end

  def exterior_collection
    Skin.pluck(:exterior)
        .compact
        .sort
        .uniq
  end

  def knifes_type_collection
    Skin.pluck(:type_skin)
        .uniq
        .compact
        .map! { |types| types['Faca'] }
        .compact
  end

  def knifes_collection
    @knifes = []
    Skin.where(type_skin: knifes_type_collection).map(&:type_weapon).uniq.each do |skin|
      @knifes << skin
    end

    @knifes.sort
  end

  def gloves_type_collection
    Skin.pluck(:type_skin)
        .uniq
        .compact
        .map! { |types| types['Luvas'] }
        .compact
  end

  def gloves_collection
    @gloves = []
    Skin.where(type_skin: gloves_type_collection).map(&:description).uniq.each do |skin|
      @gloves << skin
    end

    @gloves.sort
  end

  def rifles_type_collection
    Skin.pluck(:type_skin)
        .uniq
        .compact
        .map! { |types| [types['Rifle'], types['Rifle de Precisão']] }
        .flatten
        .compact
  end

  def rifles_collection
    @rifles = []
    Skin.where(type_skin: rifles_type_collection).map(&:type_weapon).uniq.each do |skin|
      @rifles << skin
    end

    @rifles.sort
  end

  def pistols_type_collection
    Skin.pluck(:type_skin)
        .uniq
        .compact
        .map! { |types| types['Pistola'] }
        .compact
  end

  def pistols_collection
    @pistols = []
    Skin.where(type_skin: pistols_type_collection).map(&:type_weapon).uniq.each do |skin|
      @pistols << skin
    end

    @pistols.sort
  end

  def shotguns_type_collection
    Skin.pluck(:type_skin)
        .uniq
        .compact
        .map! { |types| types['Escopeta'] }
        .compact
  end

  def machineguns_collection
    @machineguns = []
    Skin.where(type_skin: machineguns_type_collection).map(&:type_weapon).uniq.each do |skin|
      @machineguns << skin
    end

    @machineguns.sort
  end

  def machineguns_type_collection
    Skin.pluck(:type_skin)
        .uniq
        .compact
        .map! { |types| types['Metralhadora'] }
        .compact
  end

  def shotguns_collection
    @shotguns = []
    Skin.where(type_skin: shotguns_type_collection).map(&:type_weapon).uniq.each do |skin|
      @shotguns << skin
    end

    @shotguns.sort
  end

  def smgs_type_collection
    Skin.pluck(:type_skin)
        .uniq
        .compact
        .map! { |types| types['Submetralhadora'] }
        .compact
  end

  def smgs_collection
    @smgs = []
    Skin.where(type_skin: smgs_type_collection).map(&:type_weapon).uniq.each do |skin|
      @smgs << skin
    end

    @smgs.sort
  end

  def stickers_type_collection
    Skin.pluck(:type_skin)
        .compact
        .map! { |types| types['Adesivo'] }
        .compact
        .uniq
  end

  def agents_type_collection
    Skin.pluck(:type_skin)
        .compact
        .map! { |types| types['Agente'] }
        .compact
        .uniq
  end

  def music_kits_type_collection
    Skin.pluck(:type_skin)
        .compact
        .map! { |types| types['Trilha Sonora'] }
        .compact
        .uniq
  end

  def graffiti_type_collection
    Skin.pluck(:type_skin)
        .compact
        .map! { |types| types['Grafite'] }
        .compact
        .uniq
  end
end
