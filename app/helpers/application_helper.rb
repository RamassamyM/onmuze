module ApplicationHelper

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

  def right_block_performance_show_render(performance)
    @performance = performance
    if current_user == @performance.user
      render 'right_block_artist_request'
    else
      render 'right_block_organizer_visitor_booking'
    end
  end

  def event_show_card(event)
    if event.photo.present?
      cl_image_tag event.photo.path, width: 200, height: 100, crop: :fill
    else
      'event.jpeg'
    end
  end

end
