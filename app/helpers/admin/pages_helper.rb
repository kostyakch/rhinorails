module Admin::PagesHelper
	def page_items(parent = nil)
		if parent.blank?
			Page.paginate(page: params[:page]).where('parent_id IS NULL')	
		else
			Page.paginate(page: params[:page]).where("parent_id = #{parent.id}")	
		end
		
	end

	def page_edit_javascripts
		<<-CODE
		function testFunc() {
			alert('test func');
		}
		CODE
	end
end
