class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

# This is a temporary way of obtaining a user"
" This will not allow for more than one user"
  def current_listener
    @current_listener = Listener.first
  end
end
