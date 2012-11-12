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
  PUBLISH_STATUS = %w[publish pending]

  attr_accessible :start_on, :publish_status

  validates :start_on, presence: true
  validates_uniqueness_of :start_on, :scope => :course_id
  validates :created_by, presence: true
  validates :publish_status, presence: true, :inclusion => { :in => PUBLISH_STATUS }

  default_scope order("start_on asc")
  scope :publish_only, where('publish_status = ?', 'publish')

  belongs_to :course
  belongs_to :user, :foreign_key => "created_by"

  before_validation :set_default_publish_status

  def pending?
    publish_status == "pending"
  end

  private
  def set_default_publish_status
    self.publish_status ||= "pending"
  end
    
end
