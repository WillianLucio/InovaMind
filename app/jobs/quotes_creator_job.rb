class QuotesCreatorJob < ApplicationJob
  queue_as :scraping

  def perform(quotes)
    quotes.each { |quote| Quote.create(quote) }
  end
end
