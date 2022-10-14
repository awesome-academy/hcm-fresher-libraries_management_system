class BooksController < ApplicationController
  before_action ->{load_book(params[:id])}, only: :show

  def index
    @search = Book.ransack(params[:q])
    @search.sorts = "name asc" if @search.sorts.empty?
    @pagy, @books = pagy(
      @search.result.includes(:author).search_cate(params[:category]),
      items: Settings.length.digit_12
    )
  end

  def show
    @books = Book.group_author(@book.author_id).not_current_book(@book.id)
  end
end
