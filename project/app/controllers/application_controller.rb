class ApplicationController < ActionController::API

  include Response
  include AppExceptionHandler

  before_action :authorize_request

  attr_reader :current_user

  def initialize
    @logger = Logger.new STDOUT
  end

  def authorize_request
    @current_user = AuthorizeApiRequest.new(request.headers).authorize[:user]
  end

end
