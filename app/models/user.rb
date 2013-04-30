# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string(20)       not null
#  email      :string(100)      not null
#  fio        :string(255)
#  active     :boolean
#  roles      :string(255)      not null
#  password   :string(20)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true
end
