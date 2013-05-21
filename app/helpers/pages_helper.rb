module PagesHelper
	def article_list(parent)
		if parent.ptype == 'article'
			Page.where("parent_id = #{parent.id} AND active = true")
		else
			[]
		end		
	end
	
end
