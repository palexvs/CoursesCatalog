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
#

class Course < ActiveRecord::Base
  PUBLISH_STATUS = %w[publish pending draft]
  
  attr_accessible :name, :desc, :start_by_schedule, :publish_status

  validates :name, presence: true, length: { minimum: 5, maximum: 255 }
  validates :created_by, presence: true
  validates :publish_status, presence: true, :inclusion => { :in => PUBLISH_STATUS }

  has_many :track_its, :dependent => :destroy
  has_many :users, :through => :track_its

  has_many :start_dates, :dependent => :destroy

  scope :with_closest_start_date, Course.select("courses.*, nd.date").where('publish_status = ?', 'publish')
    .joins('LEFT OUTER JOIN 
        (select course_id, min(start_on) as date from start_dates where start_on > \''+(Date.today-7).to_s(:db)+'\' group by course_id ) as nd 
      ON nd.course_id = courses.id')


  after_save :remove_start_dates, :if => "!start_by_schedule"

  private
  def remove_start_dates
    self.start_dates.destroy_all
  end
end