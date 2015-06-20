class SessionsController < ApplicationController
  include ParamsFor::Connectors::Glue
  params_for :session, only: [:create]

  # Login form to create a new  sessions
  #
  # GET /login
  def new
    @user = User.new
    if current_user.present?
      redirect_to root_path
    else
      render action: :login
    end
  end

  # Create a user session or renders the session form errors
  #
  # POST /sessions
  def create
    @user = User.new(session_params)
    if @user.valid?
      reset_session if current_user.present?
      write_session!
      redirect_to root_path
    else
      flash[:warning] = 'There was a problem creating your session. Please check it below'
      render action: :login
    end
  end

  # Deletes the exiting session and redirects to login path
  #
  # DELETE /logout
  def destroy
    reset_session if current_user.present?
    redirect_to login_path
  end

  private

  # Writes the user information into the session
  #
  def write_session!
    session[:username] = @user.username
    session[:dialect] = @user.dialect
  end
end
