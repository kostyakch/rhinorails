# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(250)
#  email           :string(100)      not null
#  active          :boolean          default(TRUE), not null
#  roles           :string(255)      default("ROLE_USER"), not null
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  remember_token  :string(255)
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
