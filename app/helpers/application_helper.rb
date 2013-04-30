module ApplicationHelper
	# Returns the full title on a per-page basis.
	def full_title(page_title)
		base_title = "RhinoCMS"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end

	def top_menu
		"test"
		Page.all do |item|
			"<li>#{item.name}</li>"
		end
	end
end
