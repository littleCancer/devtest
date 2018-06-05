class ApplicationController < ActionController::API

  include Response
  include AppExceptionHandler

  def initialize
    @logger = Logger.new STDOUT
  end


end
