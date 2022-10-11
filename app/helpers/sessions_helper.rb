module SessionsHelper
  def remove_book_from_cart
    if session[:book_ids].include? params[:book_id]
      session[:book_ids].delete(params[:book_id])
      flash[:info] = t ".remove_book_success"
    else
      flash[:danger] = t ".remove_book_failed"
    end
  end

  def remove_cart
    session.delete :book_ids
    flash[:info] = t ".delete_cart"
  end
end
