class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

  def after_sign_out_path_for(resource_or_scope)
    session[:fully_registered] = false
    root_path
  end
end
