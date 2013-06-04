class Blog < ActiveRecord::Base
	before_validation :title_to_slug
	after_initialize :set_publish_date

	attr_accessible :active, :has_comments, :num_comments, :post, :slug, :spost, :status, :title, :publish_date

	default_scope order: 'publish_date DESC'

	has_many :blog_comment, :order => 'id', :autosave => true, :dependent => :destroy
	accepts_nested_attributes_for :blog_comment, :allow_destroy => true  

  # Validations
  validates :title, :slug, :spost, :post, presence: true
  validates :title, length: { maximum: 255 }
  validates :slug, length: { maximum: 100 }

  protected
    def set_publish_date
      self.publish_date = Time.now if !self.publish_date.present?
    end 

    def title_to_slug
      if !self.slug.present?
        self.slug = Utils.to_slug(self.title)
      else
        self.slug = Utils.to_slug(self.slug)
      end         
    end 
end
