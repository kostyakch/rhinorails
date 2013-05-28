class MessagesController < ApplicationController
  def new
  	@message = Message.new
  end

  def create
	@message = Message.new(params[:message])

	if @message.valid?
		UserMailer.send_email(@message).deliver

		flash[:info] = t('_EMAIL_SUCCESS_SEND')
		redirect_to root_url  
	else
		render 'new'
	end
  end
end
