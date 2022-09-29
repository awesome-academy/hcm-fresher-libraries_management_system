class CartBooksController < ApplicationController
  def destroy
    if session[:book_ids].include?(params[:book_id])
      remove_book_from_cart
    else
      flash[:danger] = t ".remove_book_failed"
    end
    redirect_to carts_path
  end
end
