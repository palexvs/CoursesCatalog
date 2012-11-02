# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  desc       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Course < ActiveRecord::Base
  attr_accessible :desc, :name

  has_many :track_its, :dependent => :destroy
  has_many :users, :through => :track_its
end
