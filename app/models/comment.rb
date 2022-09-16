class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, presence: true,
    length: {maximum: Settings.length.digit_255}
end
