# == Schema Information
#
# Table name: start_dates
#
#  id             :integer          not null, primary key
#  course_id      :integer          not null
#  start_on       :date             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  created_by     :integer          not null
#  publish_status :string(255)      not null
#

class StartDate < ActiveRecord::Base
  PUBLISH_STATUS = %w[publish pending draft]

  attr_accessible :start_on, :publish_status

  validates :start_on, presence: true
  validates_uniqueness_of :start_on, :scope => :course_id
  validates :created_by, presence: true
  validates :publish_status, presence: true, :inclusion => { :in => PUBLISH_STATUS }

  default_scope order("start_on desc")

  belongs_to :course
end
