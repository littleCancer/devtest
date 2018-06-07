require 'net/http'
require 'open-uri'

class DataProviders::WebDataProvider

  def self.fetchCalculationData(panel_provider)

    case panel_provider.id
    when 1
      dataForProviderType1
    when 2
      dataForProviderType2
    when 3
      dataForProviderType3
    else
      dataForProviderDefault
    end

  end

  private

  def self.dataForProviderType1
    Net::HTTP.get_response(URI.parse('http://time.com')).body
  end

  def self.dataForProviderType2
    open("http://openlibrary.org/search.json?q=the+lord+of+the+rings")
  end

  def self.dataForProviderType3
    dataForProviderType1
  end

  def self.dataForProviderDefault
    dataForProviderType1
  end

end