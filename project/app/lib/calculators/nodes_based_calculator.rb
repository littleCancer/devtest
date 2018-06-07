require 'rubygems'
require 'nokogiri'

module Calculators

  class NodesBasedCalculator

    def price(data)
      page = Nokogiri::HTML(data)
      result = page.enum_for(:traverse).map.count / 100
      result
    end

  end

end