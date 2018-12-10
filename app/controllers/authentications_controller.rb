class AuthenticationsController < ApplicationController
  def create
    payload = { email: params['email'], password: params['password'] }

    token = JWT.encode payload, Rails.application.secrets.HMAC_SECRET, 'HS256'
    render json: { token: token }
  end
end
