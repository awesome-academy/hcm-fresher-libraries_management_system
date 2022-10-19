class Book < ApplicationRecord
  belongs_to :author
  enum category: {child: 0, noval: 1, detective: 2, love_story: 3, life: 4}

  has_one_attached :image
  has_many :request_items, dependent: :destroy
  has_many :requests, through: :request_items
  has_many :comments, dependent: :destroy

  delegate :name, to: :author, prefix: true
  ransack_alias :book_author, :author_name_or_name

  scope :group_author, ->(id){where author_id: id}
  scope :not_current_book, ->(book){where.not(id: book)}
  scope :search_cate, ->(cate){where category: cate if cate.present?}
  scope :by_ids, ->(ids){where id: ids}

  validates :describe, presence: true,
    length: {maximum: Settings.length.digit_255}
  validates :name, presence: true,
    length: {maximum: Settings.length.digit_50}
  validates :publisher, presence: true,
    length: {maximum: Settings.length.digit_50}
  validates :quantity, presence: true, numericality: {only_integer: true}

  CSV_ATTRIBUTES = %w(Name Publisher Category Author_name Quantity).freeze

  def to_csv
    [name, publisher, category, author_name, quantity]
  end

  def self.file_csv
    CSV.generate(option = {}) do |file|
      file << Book::CSV_ATTRIBUTES
      all.includes(:author).each do |book|
        file << book.to_csv
      end
    end
  end
end
