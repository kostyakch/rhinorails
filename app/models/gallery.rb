class Gallery < ActiveRecord::Base
  #3attr_accessible :active, :descr, :name, :url

  has_many :gallery_image, :order => 'position', :autosave => true, :dependent => :destroy
  accepts_nested_attributes_for :gallery_image, :allow_destroy => true

  # Validations
  validates :name, :length => { :in => 2..150 }, uniqueness: true


end
