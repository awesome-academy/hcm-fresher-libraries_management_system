class Admin::RequestsController < AdminController
  def index
    @requests = Request.order_day_begin.includes(:user, :books)
  end

  def show
    @request = Request.find_by id: params[:id]
    return if @request

    flash[:danger] = t ".request_invalid"
    redirect_to admin_requests_path
  end
end
