module AppExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class NotAuthorized < StandardError; end
  class Forbidden < StandardError; end
  class InvalidParams < StandardError; end


  included do

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    rescue_from AppExceptionHandler::AuthenticationError, with: :unauthorized

    rescue_from AppExceptionHandler::MissingToken, with: :unprocessable

    rescue_from AppExceptionHandler::InvalidToken, with: :unprocessable

    rescue_from AppExceptionHandler::NotAuthorized, with: :unauthorized

    rescue_from AppExceptionHandler::Forbidden, with: :forbidden

    rescue_from AppExceptionHandler::InvalidParams, with: :unprocessable

  end


  private

  def unprocessable(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  def unauthorized(e)
    json_response( { message: e.message }, :unauthorized)
  end

  def not_found(e)
    json_response({ message: 'Bad Params' }, :not_found)
  end

  def forbidden(e)
    json_response({ message: e.message }, :forbidden)
  end

  def invalid_params(e)
    json_response({ message: e.message }, :bad_request)
  end

end