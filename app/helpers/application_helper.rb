module ApplicationHelper

  def add_navbar_unless_homepage
    unless controller_name == "pages"
      render 'shared/navbar'
    end
  end

  def add_modal_after_signup_if_nothing_created
    if complete_profile?
      render 'pages/modal'
    end
  end

  def complete_profile?
    user_not_prompted = user_signed_in? && current_user.places.empty? && current_user.performances.empty? && !session[:fully_registered]
    session[:fully_registered] = true if user_not_prompted
    return user_not_prompted
  end

  def owner?
    !current_user.places.empty?
  end

  def artist?
    !current_user.performances.empty?
  end

  def place_show_banner(place)
    if place.photo.present?
      render 'shared/banner-with-cloudinary', instance: place
    else
      render 'shared/banner-with-asset', asset_url: image_url('places.jpg')
    end
  end

  def right_block_performance_show_render(performance, proposal)
    if current_user == performance.user
      render 'performances/right_block_artist_request'
    else
      render 'performances/right_block_organizer_visitor_booking', performance: performance, proposal: proposal
    end
  end
end
