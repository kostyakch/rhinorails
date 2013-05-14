module ApplicationHelper
	# Returns the full title on a per-page basis.
	def full_title(page_title)
		base_title = Setting.find_by_name('site_name') ? Setting.find_by_name('site_name').value : "RhinoCMS"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end

	def top_menu
		Page.where('active = true AND menu = true AND parent_id IS NULL')
	end

	def meta_tags(page)
		res = ''		
		if page and page.page_field
			page.page_field.where("ftype = 'meta'").each do |meta|
				res += "<meta name=\"#{meta.name}\" content=\"#{meta.value}\" />\n"
			end
		end

		raw res		
	end  


end
