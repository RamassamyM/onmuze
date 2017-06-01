class PromotionsController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @promotion = @event.promotions.new()
    @promotion.name = @event.name
    message_array = []
    @event.proposals.confirmed.each do |proposal|
      message_array << "#{proposal.performance.name.capitalize} is performing."
    end
    message_test = "There's an amazing event which takes place in #{@event.place.name} on #{@event.scheduled_at.strftime("%A, %d %b %Y")} at #{@event.scheduled_at.strftime("%H:%M") } : come and share !"
    @promotion.message = message_test + ' ' + message_array.join(' ')
    @promotion.eventpage_url = 'http://onmuze.com/events/' + @event.id.to_s
    @promotion.picture_url = get_picture_url(@event)
    if @promotion.save
      post_on_fb(@promotion)
      @genres = Genre.all.map(&:event_type).uniq
      redirect_to event_path(@event)
    else
      @genres = Genre.all.map(&:event_type).uniq
      flash[:alert] = "Sorry, an error occured and your event could not be promoted"
      render 'events/show'
    end
  end

  private

  def post_on_fb(promotion)
    graph = Koala::Facebook::API.new(ENV['FB_TOKEN'])
    graph.put_connections("me", "feed", message: promotion.message, picture: 'http://res.cloudinary.com/onmuze/image/upload/v1496241330/lrfvqzybfp61fiarrr9w.jpg', link: 'www.onmuze.com')
  end

  def get_picture_url(event)
    prefix = 'http://res.cloudinary.com/onmuze/image/upload/'
    if event.photo
      prefix + event.photo.path
    elsif event.proposals.confirmed.first && event.proposals.confirmed.first.photo
      prefix + event.proposals.confirmed.first.photo.path
    else
      prefix + 'v1496241330/lrfvqzybfp61fiarrr9w.jpg'
    end
  end
end
