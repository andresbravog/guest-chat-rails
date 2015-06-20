class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # GET /
  def index
  end

  private

  # Returns current user if exists
  #
  # @retuns [User]
  def current_user
    return nil unless session[:username].present?
    @current_user ||= User.new(session)
  end

  # Checks current user or redirect to login path
  #
  def authenticate_user!
    return if current_user.present?
    redirect_to login_path
  end
end
