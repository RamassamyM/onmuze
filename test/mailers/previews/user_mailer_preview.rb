class UserMailerPreview < ActionMailer::Preview
  def welcome
    user = User.first
    UserMailer.welcome(user)
  end

  def send_proposal
    # A proposal is sent to a performance by an event
    @performance = Performance.find(55)
    @user = @performance.user
    @event = Event.find(9)

    UserMailer.send_proposal(@performance, @event)
  end
end
