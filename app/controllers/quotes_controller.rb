class QuotesController < ApplicationController
  before_action :authenticate, only: :search

  def search
    quotes = Quote.search(params['tag_search'])
    render json: { quotes: ActiveModelSerializers::SerializableResource.new(quotes) }
  end

  def authenticate
    authenticate_or_request_with_http_token do |token|
      hmac_secret = 'inovamind<3'
      JWT.decode token, hmac_secret, true, algorithm: 'HS256'
    end
  end
end
