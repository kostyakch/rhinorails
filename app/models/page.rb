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
  after_initialize :set_publish_date

  # Associations
  #default_scope order: 'position'
  default_scope { order 'position' }

  acts_as_list scope: [:parent_id, :publish_date]

  #has_many :page_content, :order => 'position', :autosave => true, :dependent => :destroy  
  has_many :page_content, -> { order 'position' }, :autosave => true, :dependent => :destroy  
  accepts_nested_attributes_for :page_content, :allow_destroy => true

  #has_many :page_field, :order => 'position', :autosave => true, :dependent => :destroy
  has_many :page_field, -> { order 'position' }, :autosave => true, :dependent => :destroy
  accepts_nested_attributes_for :page_field, :allow_destroy => true

  has_many :page_comment,  -> { order 'id' }, :autosave => true, :dependent => :destroy
  accepts_nested_attributes_for :page_comment, :allow_destroy => true 

  belongs_to :user#, polymorphic: true
  accepts_nested_attributes_for :user #, :allow_destroy => true

  # Validations
  validates :name, :slug, :position, :menu, presence: true

  validates :name, length: { maximum: 255 }
  validates :slug, length: { maximum: 100 }

  #VALID_SLUG_REGEX = %r{^([-_/.A-Za-z0-9А-Яа-я]*|/)$}
  VALID_SLUG_REGEX = /\A[-_.\/A-Za-z0-9А-Яа-я]+\z/i
  validates :slug, uniqueness: { case_sensitive: false }, format: { with: VALID_SLUG_REGEX }
  validates_uniqueness_of :slug, :scope => :parent_id


  def content_by_name(name)
    if self.page_content.find_by_name(name).present?
      self.page_content.find_by_name(name).content 
    else
      ''
    end
  end

  def field_by_name(name)
    if self.page_field.find_by_name(name).present?
      self.page_field.find_by_name(name).value 
    else
      ''
    end
  end

  def children(active = true)
    if active
      Page.where('parent_id = ? AND active = true', self.id)
    else
      Page.where('parent_id = ?', self.id)
    end
  end

  # Сформируем заголовок страницы
  def title
    if self.field_by_name('title').present?
      self.field_by_name('title')
    else
      self.name
    end
  end

  def parent
    Page.find(self.parent_id) if self.parent_id.present?
  end

  def comment_count
    PageComment.where('page_id = ? AND approved = true', self.id).count
  end  

  protected
    def set_publish_date
      self.publish_date = Time.now if !self.publish_date.present?
    end

    def name_to_slug
      if !self.slug.present?
        if self.parent_id.present?
          parent = Page.find_by_id(self.parent_id)
          self.slug = parent.slug + "/" + Rhino::Utils.to_slug(self.name)
        else
          self.slug = Rhino::Utils.to_slug(self.name)
        end
      else
        self.slug = Rhino::Utils.to_slug(self.slug)
      end
    end

  class << self

    def find_by_path(path)
      return self.find_by_slug(path, :conditions => ['active=? and publish_date <= ?', true, Time.now])
    end




  end


end
