# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  name       :string(255)
#  slug       :string(100)
#  position   :integer          not null
#  visible    :integer          default(1)
#  menu       :integer          default(1)
#  active     :boolean          default(TRUE)
#  sm_p       :string(7)        default("weekly"), not null
#  st_pr      :decimal(10, 2)   default(0.5), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Page < ActiveRecord::Base
  class MissingRootPageError < StandardError
    def initialize(message = 'Database missing root page'); super end
  end


  #attr_accessible :name, :slug, :position, :visible, :menu, :active

  # Callbacks
  #before_save :update_virtual, :update_status, :set_allowed_children_cache

  # Associations
  #acts_as_tree :order => 'virtual DESC, title ASC'
  has_many :page_content, :class_name => 'PageContent', :order => 'id', :dependent => :destroy
  accepts_nested_attributes_for :page_content, :allow_destroy => true

  #has_many :fields, :class_name => 'PageField', :order => 'id', :dependent => :destroy
  #accepts_nested_attributes_for :fields, :allow_destroy => true

  # Validations
  validates_presence_of :name, :slug, :position, :visible, :menu, :active

  validates_length_of :name, :maximum => 255
  validates_length_of :slug, :maximum => 100

  validates_format_of :slug, :with => %r{^([-_.A-Za-z0-9]*|/)$}
  validates_uniqueness_of :slug, :scope => :parent_id

  validate :valid_class_name



  class << self

    def find_by_path(path)
      return self.find_by_slug(path)
    end

  end


end
