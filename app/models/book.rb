class Book < ApplicationRecord
  belongs_to :author

  has_one_attached :image
  has_many :request_items, dependent: :destroy
  has_many :requests, through: :request_item
  has_many :comments, dependent: :destroy

  validates :describe, presence: true,
    length: {maximum: Settings.length.digit_255}
  validates :name, presence: true,
    length: {maximum: Settings.length.digit_50}
  validates :publisher, presence: true,
    length: {maximum: Settings.length.digit_50}
  validates :category, presence: true,
    length: {maximum: Settings.length.digit_50}
  validates :quantity, presence: true, numericality: {only_integer: true}
end
