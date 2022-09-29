class RequestsController < ApplicationController
  before_action :exist_book_ids_into_session, only: :create

  def create
    @request = current_user.requests.build(request_params)
    @books = Book.by_ids(session[:book_ids])
    @books.each do |book|
      @request.request_items.build(book_id: book.id, quantity: 1)
    end
    if @request.save
      flash[:info] = t ".create_req_success"
      session.delete :book_ids
    else
      flash[:danger] = t ".create_req_fail"
    end
    redirect_to root_path
  end

  private

  def request_params
    params.require(:request).permit(:day_begin, :day_end)
  end

  def exist_book_ids_into_session
    unless session[:book_ids].any?
      flash[:warning] = t ".no_book"
      return redirect_to root_path
    end
    @books = Book.find session[:book_ids]
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = t ".book_invalid"
    redirect_to root_path
  end
end
