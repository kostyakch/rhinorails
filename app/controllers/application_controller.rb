class ApplicationController < ActionController::Base
  before_filter :check_uri if Rails.configuration.redirect_to_www
	 
  def check_uri
    redirect_to request.protocol + "www." + request.host_with_port + request.fullpath if !/^www/.match(request.host)
  end
end
