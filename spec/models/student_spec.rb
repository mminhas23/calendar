require 'spec_helper'

describe Student do

  context 'validations' do
    it { should validate_presence_of(:first_name)}
    it { should validate_presence_of(:last_name)}
    it { should validate_presence_of(:email)}
    it { should validate_presence_of(:contact_number)}
    it { should validate_presence_of(:dob)}
    it { should validate_presence_of(:address)}
    it { should validate_presence_of(:payment_method)}
  end

  context 'associations' do
    it { should have_many(:comments).dependent(:destroy)}
    it { should have_and_belong_to_many(:courses) }
    it { should have_and_belong_to_many(:batches) }
  end

  it "should have a unique identifier" do
    student  = FactoryGirl.create(:student)
    student.identifier.should_not be_nil
  end

  it "should be invalid if company details are missing for a 'Type_3' student'" do
    FactoryGirl.build(:student, :student_type=>'Type_3').should be_invalid
  end

  it "should be valid if company details are provided for a 'Type_3' student'" do
    FactoryGirl.build(:student,
                                            :student_type=>'Type_3',
                                            :company_name=>'Sensis',
                                            :company_address=>'Lonsdale Street',
                                            :company_contact_name=>'Evgueni',
                                            :company_contact_number=>'03 8865 4321').should be_valid
  end
end