require 'open-uri'

module Calculators

  class JsonBasedCalculator

    MIN_ARRAY_LENGTH = 10

    def price(data)
      json = JSON.load(data)

      arrays_count = count_arrays_number json, 10
      arrays_count
    end

    def count_arrays_number(element, limit)
      result = 0

      element.each_value do |value|
        if value.is_a?(Array)
          result += 1 if value.count > limit
          value.each do |array_value|
            result += count_arrays_number(array_value, limit) if array_value.respond_to? :each_value
          end
        elsif value.is_a?(Hash)
          result += count_arrays_number value, limit
        end
      end

      result

    end

  end

end