class BooksController < ApplicationController
  def index
    @pagy, @books = pagy Book.order_name, items: Settings.length.digit_12
  end

  def show
    @book = Book.find_by id: params[:id]
    if @book.nil?
      flash[:danger] = t ".book_invalid"
      redirect_to root_url
    else
      @books = Book.group_author(@book.author_id).not_current_book(@book.id)
    end
  end
end
