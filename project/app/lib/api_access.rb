class ApiAccess

  attr_reader :access, :default

  def initialize(access, default = false)
    @access = access
    @default = default
  end

  def matches?(request)
    default || check_headers(request.headers)
  end

  private

  def check_headers(headers)
    accept = headers[:accept]
    accept && accept.include?("application/vnd.agency.#{@access}+json")
  end

end