class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :dob
  has_many :books
end
