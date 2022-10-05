class AdminController < ApplicationController
  layout "admin"
  before_action :require_admin

  private

  def require_admin
    return if current_user.admin?

    flash[:danger] = t ".not_permit"
    redirect_to root_path
  end
end
