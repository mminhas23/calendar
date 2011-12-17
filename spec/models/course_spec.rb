require 'spec_helper'

describe Course do

  context  'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:course_code)}
    it { should validate_presence_of(:start_date)}
    it { should validate_presence_of(:end_date)}
    it { should validate_presence_of(:total_seats)}
  end

  context  'associations' do
    it { should belong_to(:category)}
    it { should have_many(:batches).dependent(:destroy)}
    it { should have_and_belong_to_many(:students) }
  end
end