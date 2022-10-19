class SendEmailJob < ApplicationJob
  queue_as :default

  discard_on ActiveRecord::RecordInvalid

  def perform user
    @user = user
    user.send_mail_create_request
    raise ActiveRecord::RecordInvalid
  end
end
