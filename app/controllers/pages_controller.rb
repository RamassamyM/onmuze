class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @genres = Genre.all.map(&:event_type).uniq
  end
end
