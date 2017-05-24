module ApplicationHelper

  def place_show_banner(place)
    if place.photo.present?
      render 'shared/banner-with-cloudinary', instance: place
    else
      render 'shared/banner-with-asset', asset_url: image_url('places.jpg')
    end
  end

end
