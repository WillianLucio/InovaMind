class AuthenticationsController < ApplicationController
  def create
    hmac_secret = 'inovamind<3'
    payload = { email: params['email'], password: params['password'] }

    token = JWT.encode payload, hmac_secret, 'HS256'
    render json: { token: token }
  end
end
