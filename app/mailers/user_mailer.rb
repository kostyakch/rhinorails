class UserMailer < ActionMailer::Base

  def send_email(message)
  	@message = message

  	mail(:to => default_mail, :from => message.eml, :subject => t('_SUBJECT_SEND_EMAIL'))
  end

  def send_mail_to_manager(message)
  	@message = message

  	mail(:to => manager_mail, :from => message.eml, :subject => t('_SUBJECT_SEND_EMAIL'))
  end

  def send_mail_to_customer(message)
    @message = message

    mail(:to => message.eml, :from => manager_mail, :subject => t('_SUBJECT_SEND_EMAIL'))
  end


  private
    def default_mail
      if Setting.find_by_name('mail_to').present?
        Setting.find_by_name('mail_to').value
      else
        'noname@test.com'
      end
    end

    def manager_mail
      if Setting.find_by_name('manager_mail').present?
        Setting.find_by_name('manager_mail').value
      else
        'noname@test.com'
      end
    end

end
