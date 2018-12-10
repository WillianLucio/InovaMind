class QuotesController < ApplicationController
  before_action :authenticate, only: :search

  def search
    if Quote.tag_searched?(params['tag_search'])
      quotes = Quote.elem_match(tags: { tag: params['tag_search'] })
      render json: { quotes: ActiveModelSerializers::SerializableResource.new(quotes) }
    else
      render json: { quotes: ActiveModelSerializers::SerializableResource.new(
        QuotesScraper.scraping(params['tag_search'])
      ) }
    end
  end

  def authenticate
    authenticate_or_request_with_http_token do |token|
      hmac_secret = 'inovamind<3'
      JWT.decode token, hmac_secret, true, algorithm: 'HS256'
    end
  end
end
