# == Schema Information
# Schema version: 20100909054222
#
# Table name: microposts
#
#  id         :integer(4)      not null, primary key
#  content    :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  belongs_to :user

  validates :content, :length => { :maximum => 140 }
end
