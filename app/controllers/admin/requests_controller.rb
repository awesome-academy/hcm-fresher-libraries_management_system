class Admin::RequestsController < AdminController
  before_action :load_request, only: %i(show edit update)
  load_and_authorize_resource

  def index
    @search = Request.ransack(params[:q])
    @requests = @search.result.includes(:user, :books, :request_items)
  end

  def show; end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      @request.update! request_params
      if @request.fulfilled?
        @request.books.each do |book|
          book.update! quantity: book.quantity - 1
        end
      end
      flash[:info] = t ".update_success"
      redirect_to admin_requests_path
    rescue ActiveRecord::RecordInvalid
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
