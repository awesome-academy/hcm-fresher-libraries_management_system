class Api::V1::ApiController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json

  protected

  def render_resource resource
    if resource.errors.empty?
      render json: resource
    else
      validation_error resource
    end
  end

  def validation_error resource
    render json: {errors: [{
      status: "400",
      title: "Bad Request",
      detail: resource.errors
    }]}, status: :bad_request
  end
end
