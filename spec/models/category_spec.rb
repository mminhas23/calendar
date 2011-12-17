require 'spec_helper'
describe Category do

  it "should not be persisted when empty" do
    Category.create.should_not be_persisted
  end

  it "should be persisted when code and description are provided" do
    Category.new(:code =>'TST', :description=>'Test Category').should be_valid
  end

  it "should not be persisted when code is not provided" do
    Category.new(:code =>'TST').should be_invalid
  end

  it "should not be persisted when description is not provided" do
    Category.new(:description =>'Test Category').should be_invalid
  end

  it "should not be persisted if code already exists" do
    Category.create!(:code => 'TST', :description =>'Test Category').should be_persisted
    Category.new(:code => 'TST', :description =>'Test Category').should be_invalid
  end

   it {should have_many(:courses).dependent(:destroy)}
end