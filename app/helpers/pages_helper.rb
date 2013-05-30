module PagesHelper
	def article_list(parent, per_page = 20)
		if parent.ptype == 'article'
			Page.where("parent_id = ? AND active = true", parent.id).
				paginate(:page => params[:page], :per_page => per_page)
		else
			[]
		end		
	end
	
	def breadcrumbs(cur_page)
		
	end
end
