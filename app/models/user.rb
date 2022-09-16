class User < ApplicationRecord
  before_save :downcase_email
  enum role: {admin: 0, client: 1}

  has_one_attached :avatar
  has_many :requests, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates_associated :requests
  validates :name, presence: true, length: {maximum: Settings.length.digit_50}
  validates :email, presence: true,
            length: {
              minimum: Settings.length.digit_10,
              maximum: Settings.length.digit_255
            },
            format: {with: Settings.format.email},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.length.digit_6}, allow_nil: true

  has_secure_password

  def downcase_email
    email.downcase!
  end
end
