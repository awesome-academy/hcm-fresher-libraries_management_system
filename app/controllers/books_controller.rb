class BooksController < ApplicationController
  def index
    @pagy, @books = pagy Book.order_name, items: Settings.length.digit_12
  end
end
