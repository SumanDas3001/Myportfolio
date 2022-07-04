class UserMailer < ApplicationMailer
  default from: 'DasDevGuide <dasdevguide@gmail.com>'

  def send_welcome(email, name)
    @email = email
    @name = name
    mail to: @email, subject: "Welcome to DasDevGuide #{Emoji.find_by_alias("blush").raw}"
  end

  def submit_contact_us(email, name, message, subject)
    @email = email
    @name = name
    @message = message
    mail to: "dasdevguide@gmail.com", subject: subject
  end
end
