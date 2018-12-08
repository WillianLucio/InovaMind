class QuotesController < ApplicationController
  before_action :authenticate, only: :search

  def search
    render json: { html: Quote.search(params['tag_search']) }
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      hmac_secret = 'inovamind<3'
      JWT.decode token, hmac_secret, true, { algorithm: 'HS256' } 
    end
  end
end
