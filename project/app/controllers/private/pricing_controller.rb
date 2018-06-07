class Private::PricingController < Private::PrivateApiController

  before_action :validate_params

  def index

    data = DataProviders::WebDataProvider.fetchCalculationData @panel_provider

    price_calculator = Calculators::CalculatorFactory.for @panel_provider
    price = price_calculator.price data
    jsonR = json_response(price: price)

    @logger.debug "using method no #{@panel_provider.id} result -> #{jsonR}"

    jsonR
  end


  private

  def validate_params

    price_params = Validations::PriceParamsValidator.new(params)

    if price_params.valid?
      @panel_provider = PanelProvider.find(price_params.country.panel_provider_id)
    else
      raise(AppExceptionHandler::InvalidParams,
            "Validation failed errors:#{price_params.errors}")

    end

  end


end
