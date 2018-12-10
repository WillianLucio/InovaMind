class QuotesCreatorJob < ApplicationJob
  queue_as :scraping

  def perform(quote)
    Quote.create(quote)
  end
end
