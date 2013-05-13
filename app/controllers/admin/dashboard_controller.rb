class Admin::DashboardController < ApplicationController
	layout 'admin/application'
	before_filter :admin_only	

	def index
	end
end
