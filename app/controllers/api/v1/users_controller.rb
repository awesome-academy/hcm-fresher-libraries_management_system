class Api::V1::UsersController < Api::V1::ApiController
  before_action :authenticate_user!

  def show
    @user = ActiveModelSerializers::SerializableResource.new(current_user, {})
    if @user
      render json: {status: true, data: {user: @user}}, status: :ok
    else
      render json: {status: false, data: {}}, status: :not_found
    end
  end

  def update
    if current_user.update! user_params
      render json: {status: true, data: {user: current_user}}, status: :ok
    else
      render json:
        {status: false, error: current_user.errors}, status: :not_permit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
