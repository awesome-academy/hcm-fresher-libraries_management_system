class Users::SessionsController < Devise::SessionsController
  def destroy
    @referer_url = root_path
    super
  end
end
