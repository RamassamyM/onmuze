class UserMailer < ApplicationMailer
  def send_proposal(performance)
    # A proposal is sent to a performance by an event
    @performance = performance
    @user = @performance.user

    mail to: @user.email, subject: 'New OnMuze proposal'
  end

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Test')
    # This will render a view in `app/views/user_mailer`!
  end
end
