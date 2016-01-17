class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :flash_to_headers

  def flash_to_headers
    return unless request.xhr?
    flash[:alert] = response.headers['X-Message'] if response.headers['X-Message']
    flash.discard  
  end
end
