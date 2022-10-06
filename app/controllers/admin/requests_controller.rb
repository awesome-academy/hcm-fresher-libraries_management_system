class Admin::RequestsController < AdminController
  before_action :load_request, only: %i(show edit update)

  def index
    @requests = Request.order_day_begin.includes(:user, :books)
  end

  def show; end

  def edit; end

  def update
    if @request.update request_params
      flash[:info] = t ".update_success"
      redirect_to admin_requests_path
    else
      flash.now[:danger] = t ".update_failed"
      render :edit
    end
  end

  private

  def load_request
    @request = Request.find_by id: params[:id]
    return if @request

    flash[:danger] = t ".request_invalid"
    redirect_to admin_requests_path
  end

  def request_params
    params.require(:request).permit(Request::UPDATE_ATTRS)
  end
end
