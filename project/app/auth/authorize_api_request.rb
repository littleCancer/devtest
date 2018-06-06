class AuthorizeApiRequest


  def initialize(headers = {})
    @headers = headers
  end

  def authorize
    {
        user: user
    }
  end

  private

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token

  rescue ActiveRecord::RecordNotFound => e

    raise(
        AppExceptionHandler::InvalidToken,
        ("Invalid token #{e.message}")
    )
  end

  def decoded_auth_token
    @decoded_auth_token ||= JwtHelper.decode(http_auth_header)
  end

  def http_auth_header
    if @headers['Authorization'].present?
      return @headers['Authorization'].split(' ').last
    end
    raise(AppExceptionHandler::MissingToken, 'Missing token')
  end

end