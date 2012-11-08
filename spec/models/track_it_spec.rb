# == Schema Information
#
# Table name: track_its
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  course_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe TrackIt do

  before do
    @u = create(:user)
    @c = create(:course)
    @t = @u.track_its.build( course: @c )
  end

  subject { @t }

  it { should respond_to(:course_id) }
  it { should respond_to(:user_id) }
  it { should be_valid } 


end