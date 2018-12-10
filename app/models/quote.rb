class Quote
  include Mongoid::Document

  require 'nokogiri'
  require 'open-uri'

  field :text, type: String
  field :author, type: String
  field :author_about, type: String
  field :tags, type: Array

  validates :text, presence: true, uniqueness: true
  validates :author, :author_about, :tags, presence: true

  def self.tag_searched?(tag)
    Quote.in(tags: { tag: tag, searched: true }).any?
  end
end
