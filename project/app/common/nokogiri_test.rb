require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'


class NokogiriTest


  def self.test


    # http://time.com
    #
    # http://openlibrary.org/search.json?q=the+lord+of+the+rings


    page = Nokogiri::HTML(open("http://time.com"))
    puts 'nekad'
    puts page.class   # => Nokogiri::HTML::Document
    puts 'bese'

    tags = Hash.new(0)

    puts "page children __ #{page.children.count} "

    page.children.each do |child|

      # puts "child = #{child}"

    end

    result = page.enum_for(:traverse).map

    puts "resulten #{result}"

    count = 0
    page.traverse do |node|
      # next unless node.is_a?(Nokogiri::XML::Element)
      #

      # puts "node name #{node.name}"

      #   tags[node.name] += 1

      count += 1
    end

    # **********************
    result = page.enum_for(:traverse).map.count
    # **********************

    puts ' ----- acc ========'
    # puts "tags ------------- #{page.traverse.class}"

    # page.search('*').each do |as|
    #   puts "a be #{as}"
    # end

    puts "m try #{page.xpath("//*").count}"


    puts "n try #{page.search('*').count}"

    #
    puts "c wat #{count}"

    puts "res wat #{result}"



    html_text = page.inner_text
    acount = html_text.count 'a'
    puts " a counter #{acount}"

    #*******************************
    @data = Net::HTTP.get_response(URI.parse("http://time.com")).body
    datac = @data.count('a')
    puts " a data counter zz #{datac}"
    #******************************
    #
    #





    json_sting = open("http://openlibrary.org/search.json?q=the+lord+of+the+rings")
    # json = JSON.parse(json_sting.as_json)

    json = JSON.load(json_sting)
    puts "old ============================ "

    result = 0
    json["docs"].each do |el|
      result += el.count{|x| (x[1].is_a?(Array) && x[1].count > 10)}
    end

    puts "m result #{result}"

    # *******************************
    @arrays_count = count_arrays_number json, 10
    # ********************************

    puts "ma dal je moguce #{@arrays_count}"

  end

  def self.count_arrays_number(element, limit)
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