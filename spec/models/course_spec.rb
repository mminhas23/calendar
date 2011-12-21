require 'spec_helper'
require 'date'

describe Course do

  context  'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:course_code)}
    it { should validate_presence_of(:start_date)}
    it { should validate_presence_of(:end_date)}
    it { should validate_presence_of(:total_seats)}

    date = DateTime.now.to_date
    it { should allow_value(date).for(:start_date) }
    it { should_not allow_value(date - 10 ).for(:start_date) }
    it { should allow_value(date + 10).for(:end_date)}
  end

  context  'associations' do
    it { should belong_to(:category)}
    it { should have_many(:batches).dependent(:destroy)}
    it { should have_and_belong_to_many(:students) }
  end

  it " end date should not be before course start date" do
    FactoryGirl.build(:course, :end_date=>'2011-12-10').should be_invalid
  end
end
