module GalleryImagesHelper

	def gallery_by_url(url)
		gal = Rhinoart::Gallery.find_by_url(url)
		if gal.present?
			Rhinoart::GalleryImage.where('gallery_id = ?', gal.id)
		else
			[]
		end
	end
end
