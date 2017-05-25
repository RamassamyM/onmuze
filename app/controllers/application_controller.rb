class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :store_current_location, :unless => :devise_controller?

  private

  def after_sign_out_path_for(resource_or_scope)
    session[:fully_registered] = false
    root_path
  end

  def store_current_location
    store_location_for(:user, request.url)
  end
end




