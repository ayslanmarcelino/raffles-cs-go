# frozen_string_literal: true

module Admins
  module ItemTypesHelper
    def item_type_formatted(item_type)
      humanize_item_type = item_type.humanize

      humanize_item_type.split.map { |x| x[0].upcase + x[1..-1] }.join(' ')
    end
  end
end
