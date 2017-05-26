class UserMailerPreview < ActionMailer::Preview
  def welcome
    user = User.first
    UserMailer.welcome(user)
  end

  def send_proposal
    # A proposal is sent to a performance by an event
    @performance = Performance.find(55)
    @user = @performance.user

    UserMailer.send_proposal(@performance)
  end
end
