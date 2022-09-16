class RequestItem < ApplicationRecord
  belongs_to :book
  belongs_to :request

  validates :quantity, presence: true,
    numericality: {in: Settings.range.quantity_books}
end
