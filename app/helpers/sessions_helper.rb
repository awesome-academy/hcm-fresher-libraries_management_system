module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

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
