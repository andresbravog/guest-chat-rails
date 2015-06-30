class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, only: [:index]
  before_action :define_js_user_data, only: [:index]

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

  # Pass user variables to the js files
  #
  def define_js_user_data
    gon.push({
      :username => current_user.try(:username),
      :dialect => current_user.try(:dialect)
    })
  end

  # Checks current user or redirect to login path
  #
  def authenticate_user!
    return if current_user.present?
    redirect_to login_path
  end
end
