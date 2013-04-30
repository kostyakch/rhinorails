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

require 'spec_helper'

describe Page do
  pending "add some examples to (or delete) #{__FILE__}"
end
