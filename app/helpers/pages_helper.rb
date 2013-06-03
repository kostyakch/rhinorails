module PagesHelper
	def article_list(parent, per_page = 20)
		if parent.ptype == 'article'
			Page.where("parent_id = ? AND active = ? AND publish_date <= ?", parent.id, true, Time.now).
				paginate(:page => params[:page], :per_page => per_page)
		else
			[]
		end		
	end
	
	# 
	def breadcrumbs(cur_page)
		page = Page.find_by_slug(cur_page.slug)
		if page.present?
			if page.parent_id.present?
				[] << Page.find_by_id(page.parent_id) << page
			else
				[] << page
			end
		else
			[]
		end
	end
	
end
