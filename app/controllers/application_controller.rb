class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  protect_from_forgery with: :exception
  protect_from_forgery prepend: true

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json{head :forbidden}
      format.html{redirect_to main_app.root_url, alert: exception.message}
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i(name email password password_confirmation remember_me)
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

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
