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
  belongs_to :user
  belongs_to :course
  # attr_accessible :title, :body
end
