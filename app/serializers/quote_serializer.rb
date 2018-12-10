class QuoteSerializer < ActiveModel::Serializer
  attribute :text, key: :quote
  attributes :author, :author_about, :tags

  def tags
    object.tags.map { |tag| tag[:tag] }
  end
end
