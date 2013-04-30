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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
