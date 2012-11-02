# == Schema Information
#
# Table name: track_its
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TrackIt < ActiveRecord::Base
  attr_accessible :course
  validates_uniqueness_of :course_id, :scope => :user_id, :message => "has already added to your list" 

  belongs_to :user
  belongs_to :course
end
