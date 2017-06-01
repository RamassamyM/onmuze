class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :store_current_location, :unless => :devise_controller?

  def default_url_options
    { host: ENV['HOST'] || 'localhost:3000' }
  end

  private

  def after_sign_out_path_for(resource_or_scope)
    session[:fully_registered] = false
    root_path
  end

  def store_current_location
    store_location_for(:user, request.url)
  end

  def set_searched_in_session
    session[:searched] ||= {}
    session[:searched] = session[:searched].inject({}) { |memo, (k, v)| memo[k.to_sym] = v; memo}
  end
end
