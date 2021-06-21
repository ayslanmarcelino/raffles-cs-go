# frozen_string_literal: true

module ApplicationHelper
  def show_svg(path)
    File.open("lib/assets/images/#{path}", 'rb') do |file|
      raw file.read
    end
  end

  def formatted_field_capitalize(field)
    humanize_field = field.humanize

    humanize_field.split.map { |x| x[0].upcase + x[1..] }.join(' ')
  end

  def abbreviation(exterior)
    exterior.split.map(&:first).join.upcase
  end

  def translate_boolean(boolean)
    boolean ? t('application.positive') : t('application.negative')
  end

  def time_tradelock(date)
    days_remaining = ((date.to_time - Time.now) / 1.day)
    days_remaining = days_remaining.to_i
    days_remaining_string = days_remaining.to_i.to_s
    to_day_remaining = days_remaining == 1 ? "#{days_remaining_string} dia" : "#{days_remaining_string} dias"
    hours_remaining = (date.to_time.minus_with_coercion(1.second.ago) / 3600).to_i
    hours_remaining_string = (date.to_time.minus_with_coercion(1.second.ago) / 3600).to_i.to_s
    hours_remaining = hours_remaining == 1 ? "#{hours_remaining_string} hora" : "#{hours_remaining_string} horas"

    days_remaining < 1 ? hours_remaining : to_day_remaining
  end

  def time_tradelock_integer(date)
    days_remaining = ((date.to_time - Time.now) / 1.day)
    to_day_remaining = days_remaining.to_i
    hours_remaining = (date.to_time.minus_with_coercion(1.second.ago) / 3600).to_i

    days_remaining < 1 ? hours_remaining : to_day_remaining
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, sort: column, direction: direction, class: css_class
  end

  def positive_value?(value)
    value.positive?
  end
end
