# frozen_string_literal: true

module Admins
  module SkinTypesHelper
    def skin_type_formatted(skin_type)
      humanize_skin_type = skin_type.humanize

      humanize_skin_type.split.map { |x| x[0].upcase + x[1..-1] }.join(' ')
    end
  end
end
