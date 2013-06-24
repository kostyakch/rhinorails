class Admin::StructuresController < Admin::PagesController
	layout 'admin/application'
	
	before_filter :signed_in_user
	before_filter { access_only_roles %w[ROLE_ADMIN] }
end
