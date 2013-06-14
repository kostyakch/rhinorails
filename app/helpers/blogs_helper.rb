module BlogsHelper
	def blog_list(per_page = 20)
		Blog.where("active = ? AND publish_date <= ?", true, Time.now)
			.order('publish_date DESC')
			.paginate(:page => params[:page], :per_page => per_page)	
	end	
end
