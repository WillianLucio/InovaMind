class Quote
  include Mongoid::Document

  require 'nokogiri'
  require 'open-uri'

  field :text, type: String
  field :author, type: String
  field :author_about, type: String
  field :tags, type: Array

  def self.search(tag_search)
    if tag_searched?(tag_search)
      Quote.elem_match(tags: { tag: tag_search })
    else
      scraping(tag_search)
    end
  end

  def self.scraping(tag_search)
    doc = Nokogiri::HTML(open('http://quotes.toscrape.com/'), nil, Encoding::UTF_8.to_s)

    quotes = []
    doc.css('.quote').map do |quote_html|
      tags = quote_html.css('.tags a').map do |tag|
        { tag: tag.content, searched: tag.content == tag_search }
      end

      if tags.include?(tag: tag_search, searched: true)
        quote = Quote.new(
          text: quote_html.css('.text').first.content,
          author: quote_html.css('.author').first.content,
          author_about: quote_html.css('a').first['href'],
          tags: tags
        )

        quote.save unless quote.insered?
        quotes << quote
      end
    end

    quotes
  end

  def self.tag_searched?(tag)
    Quote.in(tags: { tag: tag, searched: true }).any?
  end

  def insered?
    Quote.where(text: text).any?
  end
end
