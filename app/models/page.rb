# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  name       :string(255)      not null
#  slug       :string(100)      not null
#  position   :integer          default(0), not null
#  visible    :integer          default(1)
#  menu       :integer          default(1)
#  active     :boolean          default(TRUE)
#  sm_p       :string(7)        default("weekly"), not null
#  st_pr      :decimal(10, 2)   default(0.5), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Page < ActiveRecord::Base
  attr_accessible :parent_id, :name, :slug, :position, :menu, :active, :page_content_attributes, :page_field_attributes

  # Associations
  default_scope order: 'position'
  #default_scope :parent_id, :dependent => :destroy

  has_many :page_content, :order => 'position', :autosave => true, :dependent => :destroy
  accepts_nested_attributes_for :page_content, :allow_destroy => true

  has_many :page_field, :order => 'position', :autosave => true, :dependent => :destroy
  accepts_nested_attributes_for :page_field, :allow_destroy => true

  #has_many :fields, :class_name => 'PageField', :order => 'id', :dependent => :destroy
  #accepts_nested_attributes_for :fields, :allow_destroy => true

  # Validations
  validates :name, :slug, :position, :menu, presence: true

  validates :name, length: { maximum: 255 }
  validates :slug, length: { maximum: 100 }

  VALID_SLUG_REGEX = %r{^([-_.A-Za-z0-9]*|/)$}
  validates :slug, uniqueness: { case_sensitive: false }, format: { with: VALID_SLUG_REGEX }
  validates_uniqueness_of :slug, :scope => :parent_id



  # validates :name,  presence: true, length: { maximum: 50 }

  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  # validates :password, presence: true, length: { minimum: 4 }
  # validates :password_confirmation, presence: true

  class << self

    def find_by_path(path)
      return self.find_by_slug(path, :conditions => ["active=?", true])
    end

  end


end
