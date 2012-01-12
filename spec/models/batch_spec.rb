require 'spec_helper'

describe Batch do
  context 'validations' do
    it{ should validate_presence_of(:code)}
    it{ should validate_presence_of(:total_seats)}
  end

  it "should be valid when its total seat count is less than the seats available for the given course" do
    FactoryGirl.build(:batch).should be_valid
  end

  it "should be in-valid when its total seat count is more than the seats available for the given course" do
    FactoryGirl.build(:batch, :total_seats=>200).should be_invalid
  end

  it "should return true when batch is full" do
    batch = FactoryGirl.build(:batch, :total_seats=>20, :seats_available=>0)
    batch.full?.should be_true
  end

  it "should not enroll a new student when full" do
    batch = FactoryGirl.build(:batch,:seats_available=>0)
    student = FactoryGirl.build(:student)
    batch.assign_student(student).should be_false
  end

  it "should enroll a new student when seats are available" do
    batch = FactoryGirl.build(:batch)
    student = FactoryGirl.build(:student)
    batch.assign_student(student).should be_true
    batch.students.size.should == 1
  end

end