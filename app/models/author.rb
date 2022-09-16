class Author < ApplicationRecord
  has_one_attached :image
  has_many :books, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.length.digit_50}
  validates :dob, presence: true
  validates :info, presence: true
end
