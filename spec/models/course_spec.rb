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

  it "end date should not be before course start date" do
    FactoryGirl.build(:course, :end_date=>'2011-12-10').should be_invalid
  end

  it "seats_remaining should be reduced by batch's total_seats when a new batch is allocated" do
    course = FactoryGirl.build(:course)
    batch = FactoryGirl.build(:batch)
    course.allocate_batch(batch).should be_true
    course.seats_remaining.should == 80
  end

  it "batch cannot be allocated if the course is full" do
    course = FactoryGirl.build(:course,:seats_remaining=>0)
    batch = FactoryGirl.build(:batch)
    course.allocate_batch(batch).should be_false
    batch.errors.size.should == 1
  end

  it "should return a list of batches available" do
    course = FactoryGirl.build(:course)
    batch1 = FactoryGirl.build(:batch,:total_seats=>60,:seats_available=>0)
    batch2 = FactoryGirl.build(:batch,:total_seats=>20,:seats_available=>20)
    batch3 = FactoryGirl.build(:batch,:total_seats=>20,:seats_available=>10)
    course.allocate_batch(batch1)
    course.allocate_batch(batch2)
    course.allocate_batch(batch3)
    course.batches_available.length.should == 2
  end

end
