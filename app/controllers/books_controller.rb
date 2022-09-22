class BooksController < ApplicationController
  before_action :load_book, only: :show

  def index
    @pagy, @books = pagy(
      Book.search_cate(params[:category]).search(params[:search]).order_name,
      items: Settings.length.digit_12
    )
  end

  def show
    @books = Book.group_author(@book.author_id).not_current_book(@book.id)
  end
end
