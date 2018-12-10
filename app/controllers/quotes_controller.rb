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

  private

  def authenticate
    authenticate_or_request_with_http_token do |token|
      JWT.decode token, Rails.application.secrets.HMAC_SECRET, true, algorithm: 'HS256'
    end
  rescue
    render json: '', status: :forbidden
  end
end
