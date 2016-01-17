class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :ensure_user_email

  #---------------------------------------------------------------------------
  private

  def ensure_user_email
    return if action_name == 'register_email'  # Ensure we don't go into an infinite loop
    redirect_to register_user_email_path(current_user) if current_user && current_user.temporary_email?
  end
end
