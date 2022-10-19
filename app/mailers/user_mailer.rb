class UserMailer < ApplicationMailer
  def create_request_success user
    @user = user
    mail to: user.email, subject: t(".create_request")
  end
end
