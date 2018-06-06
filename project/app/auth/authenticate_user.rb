class AuthenticateUser

  def initialize(email, password)
    @email = email
    @password = password
  end

  def authenticate
    JwtHelper.encode(user_id: user.id) if user
  end


  private

  def user
    @user = User.find_by(email: @email)

    return @user if @user && @user.authenticate(@password)

    raise(AppExceptionHandler::AuthenticationError, 'Invalid credentials')
  end

end