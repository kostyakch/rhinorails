class MessagesController < ApplicationController
	def new
		@message = Message.new
	end

	def create
		@message = Message.new(params[:message])

		respond_to do |format|
			if @message.valid?
				UserMailer.send_email(@message).deliver
				
				format.html { redirect_to root_url, flash[:info] = t('_EMAIL_SUCCESS_SEND') }
				format.js { }
			else
				format.html { render 'new' }
				format.js { }
			end
		end
	end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
        def page_comment_params
            params.require(:page_comment).permit!#(:name, :position, :active, questions_attributes: [:name])
        end	  
end
