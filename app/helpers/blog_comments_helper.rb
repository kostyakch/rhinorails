module BlogCommentsHelper

	# Список комментариев
	def comment_list(parent = nil, per_page = 25)
		if parent.blank? || !parent.id.present?
			BlogComment.where("approved = ?", true)
				.order('created_at DESC')
				.paginate(:page => params[:page], :per_page => per_page)	
		else
			BlogComment.where("parent_id = ? AND approved = ?", parent.id, true)
				.order('created_at DESC')
				.paginate(:page => params[:page], :per_page => per_page)	
		end
	end	
end