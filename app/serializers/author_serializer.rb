class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :dob, :info
  has_many :books, serializer: BookSerializer
end
