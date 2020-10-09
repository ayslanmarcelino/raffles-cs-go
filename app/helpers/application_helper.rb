# frozen_string_literal: true

module ApplicationHelper
  def show_svg(path)
    File.open("lib/assets/images/#{path}", 'rb') do |file|
      raw file.read
    end
  end

  def formatted_field_capitalize(field)
    humanize_field = field.humanize

    humanize_field.split.map { |x| x[0].upcase + x[1..-1] }.join(' ')
  end

  def abbreviation(exterior)
    exterior.split.map(&:first).join.upcase
  end

  def translate_boolean(boolean)
    boolean ? t('application.positive') : t('application.negative')
  end
end
