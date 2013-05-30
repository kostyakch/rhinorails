module GalleryImagesHelper

	def gallery_by_url(url)
		gal = Gallery.find_by_url(url)
		if gal.present?
			GalleryImage.where('gallery_id = ?', gal.id)
		else
			[]
		end
	end
end
