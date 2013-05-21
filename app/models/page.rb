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
  before_validation :name_to_slug

  attr_accessible :parent_id, :name, :slug, :position, :menu, :active, :ptype, :created_at, :page_content_attributes, :page_field_attributes
  

  # Associations
  default_scope order: 'position'
  #default_scope :parent_id, :dependent => :destroy

  acts_as_list scope: :parent_id #, :created_at]

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

  VALID_SLUG_REGEX = %r{^([-_/.A-Za-z0-9А-Яа-я]*|/)$}
  validates :slug, uniqueness: { case_sensitive: false }, format: { with: VALID_SLUG_REGEX }
  validates_uniqueness_of :slug, :scope => :parent_id


  def content_by_name(name)
    self.page_content.find_by_name(name)
  end

  def field_by_name(name)
    self.page_field.find_by_name(name)
  end

  # Сформируем заголовок страницы
  def title
    if self.field_by_name('title').present? and self.field_by_name('title').value.present?
      self.field_by_name('title').value
    else
      self.name
    end
  end



  protected

    def name_to_slug
      if !self.slug.present?
        if self.parent_id.present?
          parent = Page.find_by_id(self.parent_id)
          self.slug = parent.slug + "/" + self.to_slug
        else
          self.slug = self.to_slug
        end
      end
      self.slug = Russian.translit(self.slug).downcase
    end

    def to_slug(param=self.name)
      # strip the string
      ret = param.strip
   
      #blow away apostrophes
      ret.gsub! /['`]/, ""
   
      # @ --> at, and & --> and
      ret.gsub! /\s*@\s*/, " at "
      ret.gsub! /\s*&\s*/, " and "
   
      # replace all non alphanumeric, periods with dash
      ret.gsub! /\s*[^A-Za-z0-9А-Яа-я\.]\s*/, '-'
   
      # replace underscore with dash
      ret.gsub! /[-_]{2,}/, '-'
   
      # convert double underscores to single
      ret.gsub! /-+/, "-"
   
      # strip off leading/trailing dash
      ret.gsub! /\A[-\.]+|[-\.]+\z/, ""
   
      ret
    end

  class << self

    def find_by_path(path)
      return self.find_by_slug(path, :conditions => ["active=?", true])
    end




  end


end
