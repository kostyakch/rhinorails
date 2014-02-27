class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
		  sign_in user
		  redirect_back_or admin_root_path
		else
		  flash.now[:error] = t('_ERROR_AUTHENTICATE')
		    render 'new'
		end
	end

	def login_from_api
		begin
			response =  AmendiaRemote.authorize(params[:login].downcase, params[:password]) if params[:login] && params[:password]
			user = User.find_by_email(params[:login].downcase)

			# Auth admin or editor user 
			if user && user.authenticate(params[:password]) && (user.has_role?('ROLE_ADMIN') || user.has_role?('ROLE_EDITOR'))
				sign_in user
				return
			end

			# Auth remote user
			if response.code == '200' && user && user.authenticate(params[:password])
				remote_user = JSON.parse(response.body)

				# Check for role
				if !has_role?(remote_user['roles'])
					redirect_to root_url
					return
				end

				user.update!(remember_token: remote_user['api_token'], password: params[:password], password_confirmation: params[:password])

				sign_in user
			else				
				user.delete if user.present? && !(user.has_role?('ROLE_ADMIN') || user.has_role?('ROLE_EDITOR'))

				if response.code == '200'
					remote_user = JSON.parse(response.body)

					# Check for role
					if !has_role?(remote_user['roles'])
						redirect_to root_url
						return
					end

					user = User.new(
						email: params[:login], 
						name: remote_user['name'], 
						password: params[:password], 
						password_confirmation: params[:password],
						remember_token: remote_user['api_token']
					)
					user.save
					sign_in user
				end
			end	
		rescue Exception => e
			flash[:error] = "#{t('_ERROR_AUTHENTICATE')} (#{e.message.humanize})"
			return
		end				

		respond_to do |format|			
			flash[:error] = t('_ERROR_AUTHENTICATE') if !response || response.code != '200'
			format.html { redirect_back_or root_url  }
			format.js { }
		end		
	end

	def registration_from_api
		begin
			response = AmendiaRemote.registration(
				params[:email], 
				params[:password],			
				AmendiaRemote.config.access_role,
				params[:first_name],
				params[:last_name],
				params[:phone],
				params[:recommended_by]
			)			
		rescue Exception => e
			flash[:error] = "#{t('_ERROR_REGISTRATION')} (#{e.message.humanize})"
			return
		end



		respond_to do |format|
			if response && response.code == '201'
				flash[:success] = t('_SUCCESS_REGISTRATION')
				format.html { redirect_to root_path }
				format.js { }
			else
				flash[:error] = t('_ERROR_REGISTRATION')
				format.html { redirect_to root_path  }
				format.js { }
			end
		end
	end
	
	def destroy
		sign_out
    	redirect_to root_url
	end

	def signed_user
	    respond_to do |format|
			format.html { render 'new' }
			format.js { }
	    end		
	end

	private
		def has_role?(roles=[])
			roles.include? AmendiaRemote.config.access_role
		end
end
