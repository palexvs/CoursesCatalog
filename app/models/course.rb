# == Schema Information
#
# Table name: courses
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  desc              :text
#  created_at        :datetime
#  updated_at        :datetime
#  start_by_schedule :boolean          default(TRUE)
#

class Course < ActiveRecord::Base
  attr_accessible :name, :desc, :start_by_schedule, :start_dates_attributes

  validates :name, presence: true, length: { minimum: 5, maximum: 255 }

  has_many :track_its, :dependent => :destroy
  has_many :users, :through => :track_its
  has_many :start_dates, :dependent => :destroy

  accepts_nested_attributes_for :start_dates, allow_destroy: true

  before_save :remove_start_dates, :if => "!start_by_schedule"

  private
  def remove_start_dates
    self.start_dates = []
  end
end