module ApplicationHelper

  def place_photo(place)
    if place.photo.present?
      cl_image_path place.photo.path, crop: :fill
    else
      asset_path 'places.jpg'
    end
  end

end
