class UsersController < ApplicationController
  layout "user", except: %i(create new)
  before_action :authenticate_user!, only: :show

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".user_invalid"
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation
    )
  end
end
