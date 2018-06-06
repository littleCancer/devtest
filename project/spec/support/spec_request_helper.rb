module SpecRequestHelper

  def token_generator(user_id)

    JwtHelper.encode(user_id: user_id)

  end

  def expired_token_generator(user_id)
    JwtHelper.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  def valid_headers
    {
        'Authorization' => token_generator(user.id),
        'Content-Type' => 'application/json'
    }
  end

  def invalid_headers
    {
        'Authorization' => nil,
        'Content-Type' => 'application/json'
    }
  end

  def valid_headers_private_api
    {
        'Authorization' => token_generator(user.id),
        'Content-Type' => 'application/json',
        'Accept' => 'application/vnd.agency.private+json'
    }
  end

  def json
    JSON.parse(response.body)
  end

end