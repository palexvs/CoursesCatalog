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

require 'spec_helper'

describe Course do

  before do
    @u = create(:user)
    @c = build(:course, created_by: @u.id)
  end

  subject { @c }

  it { should respond_to(:name) }
  it { should respond_to(:desc) }
  it { should respond_to(:start_by_schedule) }
  # it { should respond_to(:url) }
  # it { should respond_to(:university_id) }
  # it { should respond_to(:status) }
  it { should respond_to(:created_by) }
  it { should respond_to(:publish_status) }

  it { @c.created_by == @u.id }
  it { @c.publish_status == "publish" }

  it { should be_valid }  

# Tests for name
  describe "when name is empty" do
    before { @c.name = "" }
    it { should_not be_valid }
  end

  describe "when name lenght > 255" do
    before { @c.name = "a" * 256 }
    it { should_not be_valid }
  end

  describe "when name lenght == 255" do
    before { @c.name = "a" * 255 }
    it { should be_valid }
  end  

  describe "when name lenght < 5" do
    before { @c.name = "a" * 4 }
    it { should_not be_valid }
  end   

# Tests for desc
  describe "when desc is empty" do
    before { @c.desc = "" }
    it { should be_valid }
  end

  describe "when desc lenght > 255" do
    before { @c.desc = "a" * 256 }
    it { should be_valid }
  end

  describe "when desc lenght == 255" do
    before { @c.desc = "a" * 255 }
    it { should be_valid }
  end  

  describe "when desc lenght < 5" do
    before { @c.desc = "a" * 4 }
    it { should be_valid }
  end

end
