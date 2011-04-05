# == Schema Information
# Schema version: 20110404201311
#
# Table name: authentications
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime
#  updated_at :datetime
#  token      :string(255)
#  secret     :string(255)
#

# == Schema Information
# Schema version: 20110331210031
#
# Table name: authentications
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# We seperate the authentication from the User so that we can have
# multiple authentication sources (i.e. LinkedIn, Facebook, email & password, 
# etc ...).
class Authentication < ActiveRecord::Base
  # a User can have_many Authentications
  belongs_to :user
end
