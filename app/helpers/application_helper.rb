module ApplicationHelper

  def color_according_status(proposal)
    case proposal
    when "pending"
      "badge-block-pending"
    when "accepted"
      "badge-block-accepted"
    when "confirmed"
      "badge-block-confirmed"
    when "declined"
      "badge-block-declined"
    else
      "badge-block-unknown"
    end
  end

  def add_appropriate_navbar
    unless is_home || user_credential_pages
      render 'shared/navbar'
    end
  end

  def add_navbar_margin
    if is_home || user_credential_pages
    else
      "page-wrapper-navbar-margin"
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
    user_not_prompted
  end

  def owner?
    user_signed_in? && !current_user.places.empty?
  end

  def artist?
    user_signed_in? && !current_user.performances.empty?
  end

  def booked?(performance)
    !performance.proposals.confirmed.empty?
  end

  def place_show_banner(place)
    if place.photo
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

  def event_show_card(event)
    if event.photo
      cl_image_path event.photo.path, width: 800, crop: :fill
    else
      image_url('event.jpg')
    end
  end

  def place_show_card(place)
    if place.photo
      cl_image_path place.photo.path, width: 800, crop: :fill
    else
      image_url('places.jpg')
    end
  end

  def performance_show_card(performance)
    if performance.avatar
      cl_image_path performance.avatar.path, width: 800, crop: :fill
    else
      image_url('artist.png')
    end
  end

  private

  def user_credential_pages
    (controller_name == 'registrations') || (controller_name == 'sessions') || (controller_name == 'passwords')
  end

  def is_home
    controller_name == "pages" && ( action_name == "home" || action_name == "choose" )
  end
end
