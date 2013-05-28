class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def send_email(message)
  	@message = message

  	mail(:to => message.email, :subject => t('_SUBJECT_SEND_EMAIL'))
  end
end
