class Admin::UsersController < AdminController
  before_action :load_user, only: :show

  def show; end
end
