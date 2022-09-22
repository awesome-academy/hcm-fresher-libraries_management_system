class RequestItem < ApplicationRecord
  belongs_to :book
  belongs_to :request

  delegate :name, to: :book, prefix: true
  validates :quantity, presence: true,
    numericality: {only_integer: true, in: Settings.range.quantity_books}

  validate :book_valid
  validate :request_valid

  private

  def book_valid
    return if book

    errors.add(:book, t(".book_invalid"))
  end

  def request_valid
    return if request

    errors.add(:request, t(".request_invalid"))
  end
end
