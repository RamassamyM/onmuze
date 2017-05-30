class UserMailer < ApplicationMailer
  def send_proposal(performance, event)
    # A proposal is sent to a performance by an event
    @performance = performance
    @event = event
    @place = event.place
    @user = @performance.user

    mail to: @user.email, subject: 'New Onmuze proposal'
  end

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Test')
    # This will render a view in `app/views/user_mailer`!
  end
end
