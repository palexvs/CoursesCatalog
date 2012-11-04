# == Schema Information
#
# Table name: start_dates
#
#  id         :integer          not null, primary key
#  course_id  :integer          not null
#  start_on   :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StartDate < ActiveRecord::Base
  attr_accessible :start_on

  validates :start_on, presence: true

  validates_uniqueness_of :start_on, :scope => :course_id

  belongs_to :course
end
