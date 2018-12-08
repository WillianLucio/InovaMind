class QuoteSerializer < ActiveModel::Serializer
  attributes :quote, :author, :author_about, :tags

  def quote
    object.text
  end

  def tags
    object.tags.map { |tag| tag[:tag] }
  end
end
