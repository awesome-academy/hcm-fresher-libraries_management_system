class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  protect_from_forgery with: :exception
  protect_from_forgery prepend: true

  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".user_invalid"
    redirect_to root_url
  end

  def load_book id
    @book = Book.find_by id: id
    return if @book

    flash[:danger] = t ".book_invalid"
    redirect_to root_url
  end
end
