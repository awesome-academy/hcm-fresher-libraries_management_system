class BookSerializer < ActiveModel::Serializer
  attributes :id, :name, :publisher, :quantity, :author
  belongs_to :author, serializer: AuthorSerializer
end
