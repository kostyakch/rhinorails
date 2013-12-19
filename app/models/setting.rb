class Setting < ActiveRecord::Base
	before_save :name_downcase

	#attr_accessible :name, :value, :descr

	default_scope order: 'name'

	validates :name, uniqueness: { case_sensitive: false }, 
		:format => { :with => /\A[-_a-zA-Z0-9]+\z/ }
	validates :name, :length => { :in => 2..150 }
	validates :value, :length => { :in => 2..250 }
	private

		def name_downcase
			self.name = self.name.downcase
		end
end
