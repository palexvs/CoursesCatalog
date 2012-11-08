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

require 'spec_helper'

describe StartDate do

  before do
    @c = build(:course)
    @d = @c.start_dates.build(start_on: (Date.today).to_s(:db))
  end

  subject { @d }

  it { should respond_to(:course_id) }
  it { should respond_to(:start_on) }
  it { should respond_to(:created_by) }
  it { should respond_to(:publish_status) }  
  it { should be_valid }  

# Tests for date
  describe "when start_on is empty" do
    before { @d.start_on = "" }
    it { should_not be_valid }
  end

  describe "when start_on in past" do
    before { @d.start_on = (Date.today - 7).to_s(:db) }
    it { should be_valid }
  end

  describe "when start_on in future" do
    before { @d.start_on = (Date.today + 7).to_s(:db) }
    it { should be_valid }
  end

  describe "when start_on format is wrong" do
    before { @d.start_on = "2012-09/98 99:99:99" }
    it { should_not be_valid }
  end   
end
