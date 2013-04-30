# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(250)
#  email           :string(100)      not null
#  active          :boolean          default(TRUE), not null
#  roles           :string(255)      default("ROLES_USER"), not null
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
