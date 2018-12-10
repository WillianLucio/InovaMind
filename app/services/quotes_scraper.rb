class QuotesScraper
  def self.scraping(tag_search)
    doc = Nokogiri::HTML(open('http://quotes.toscrape.com/'), nil, Encoding::UTF_8.to_s)

    quotes = []
    doc.css('.quote').map do |quote_html|
      tags = quote_html.css('.tags a').map do |tag|
        { tag: tag.content, searched: tag.content == tag_search }
      end

      if tags.include?(tag: tag_search, searched: true)
        quotes << {
          text: quote_html.css('.text').first.content,
          author: quote_html.css('.author').first.content,
          author_about: quote_html.css('a').first['href'],
          tags: tags
        }
      end
    end

    QuotesCreatorJob.perform_later(quotes)
    quotes
  end
end
