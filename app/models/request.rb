class Request < ApplicationRecord
  belongs_to :user
  has_many :request_items, dependent: :destroy
  has_many :books, through: :request_items

  delegate :name, to: :user, prefix: true
  enum status: {pending: 1, fulfilled: 2, rejected: 3}, _default: 1

  validates :day_begin, presence: true
  validates :day_end, presence: true

  validate :begin_end_check, if: ->{day_begin || day_end}
  validate :begin_check, if: :day_begin

  scope :order_day_begin, ->{order day_begin: :asc}

  private

  def begin_end_check
    errors.add(:day_end, t(".error_begin_end")) if day_begin > day_end
  end

  def begin_check
    errors.add(:day_begin, t(".error_begin")) if day_begin < Time.zone.now
  end
end
