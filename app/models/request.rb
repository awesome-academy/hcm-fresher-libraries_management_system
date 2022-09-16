class Request < ApplicationRecord
  belongs_to :user
  has_many :request_items, dependent: :destroy
  has_many :books, through: :request_item

  enum status: {pending: 1, fulfilled: 2, rejected: 3}
  validates :day_begin, presence: true
  validates :day_end, presence: true, if: :end_greater_begin

  def end_greater_begin
    day_end > day_begin
  end
end
