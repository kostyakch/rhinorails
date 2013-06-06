module Admin::BlogCommentsHelper
	def children_blog_comments(parent)
		BlogComment.paginate(page: params[:page]).where("parent_id = #{parent.id}")
	end
end
