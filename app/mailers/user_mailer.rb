class UserMailer < ApplicationMailer
  default from: 'cristoferj981@gmail.com'  # or your desired email

  def confirmation_instructions(user)
    @user = user
    mail(to: @user.email, subject: 'Confirmation Instructions')
  end
end