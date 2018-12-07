class AuthenticationsController < ApplicationController
  before_action :authenticate, only: :index

  def create
    hmac_secret = 'inovamind<3'

    payload = { email: params['email'], password: params['password'] }

    token = JWT.encode payload, hmac_secret, 'HS256'
    render json: { token: token }
  end

  def index
    render json: { action: 'Index' }
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      hmac_secret = 'inovamind<3'
      JWT.decode token, hmac_secret, true, { algorithm: 'HS256' } 
    end
  end
end
