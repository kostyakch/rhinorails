class GalleryImage < ActiveRecord::Base
  attr_accessible :active, :annotation, :main, :path, :position, :gallery_id, :path_cache, :images_attributes

  belongs_to :gallery, :inverse_of => :gallery_image
  acts_as_list scope: :gallery_id

  default_scope order: ['main DESC', 'position']

  # Validations
  validates :gallery_id, presence: true
  validates :path, presence: true, :uniqueness => { :scope => :gallery_id }

  mount_uploader :path, GalleryImageUploader

end
