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
end