# == Schema Information
#
# Table name: courses
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  desc              :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  start_by_schedule :boolean          default(TRUE)
#  created_by        :integer          not null
#  publish_status    :string(255)      not null
#  link              :string(255)
#

class Course < ActiveRecord::Base
  PUBLISH_STATUS = %w[draft pending publish]
  
  attr_accessible :name, :link, :desc, :start_by_schedule, :publish_status

  validates :name, presence: true, length: { minimum: 5, maximum: 255 }
  validates :link, presence: true, length: { minimum: 5, maximum: 255 }
  validates :created_by, presence: true
  validates :publish_status, presence: true, :inclusion => { :in => PUBLISH_STATUS }

  has_many :track_its, :dependent => :destroy
  has_many :users, :through => :track_its
  belongs_to :user, :foreign_key => "created_by"

  has_many :start_dates, :dependent => :destroy

  scope :publish_only, where('publish_status = ?', 'publish')
  scope :with_start_dates, includes(:start_date)
  scope :with_closest_start_date, Course.select("courses.*, nd.date")
    .joins("LEFT OUTER JOIN 
        (SELECT course_id, min(start_on) as date FROM start_dates WHERE start_on > '"+(Date.today-7).to_s(:db)+"' AND publish_status = 'publish' GROUP BY course_id ) as nd 
      ON nd.course_id = courses.id").order("nd.date asc")


  after_save :remove_start_dates, :if => "!start_by_schedule"
  before_validation :set_default_publish_status

  def draft?
    publish_status == "draft"
  end

  def pending?
    publish_status == "pending"
  end

  def publish?
    publish_status == "publish"
  end    

  private

  def remove_start_dates
    self.start_dates.destroy_all
  end

  def set_default_publish_status
    self.publish_status ||= "draft"
  end
end
