class CartsController < ApplicationController
  before_action ->{load_book(params[:book_id])}, only: :create
  before_action :check_book_id_exist, :check_book_quantity, only: :create

  def index
    @books = Book.by_ids(session[:book_ids])
    @request = current_user.requests.build
  end

  def create
    session[:book_ids] << params[:book_id]
    flash[:info] = t ".add_book_success"
    redirect_to books_path
  end

  def destroy
    remove_cart
    redirect_to carts_path
  end

  private

  def check_book_id_exist
    session[:book_ids] ||= []
    return unless session[:book_ids].include?(params[:book_id])

    flash[:danger] = t ".book_exist"
    redirect_to books_path
  end

  def check_book_quantity
    return if book.quantity < 1

    flash[:danger] = t ".book_sold_out"
    redirect_to books_path
  end
end
