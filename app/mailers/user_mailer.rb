class UserMailer < ApplicationMailer
  default from: 'DasDevGuide <dasdevguide@gmail.com>'

  def send_welcome(email, name)
    @email = email
    @name = name
    mail to: @email, subject: "Welcome to DasDevGuide #{Emoji.find_by_alias("blush").raw}"
  end
end
