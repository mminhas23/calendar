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

  it "should return a list of students with CURRENT status" do
    FactoryGirl.create(:student)
    FactoryGirl.create(:student,:status=>'CURRENT')
    FactoryGirl.create(:student,:status=>'CURRENT')
    FactoryGirl.create(:student,:status=>'ALUMNI')
    Student.with_status('CURRENT').length.should == 2
  end

  it "should return a list of students with CURRENT or UNASSIGNED status" do
    FactoryGirl.create(:student)
    FactoryGirl.create(:student,:status=>'CURRENT')
    FactoryGirl.create(:student,:status=>'CURRENT')
    FactoryGirl.create(:student,:status=>'ALUMNI')
    FactoryGirl.create(:student,:status=>'WITHDRAWN')
    Student.current_unassigned.length.should == 3

  end

  it "should update the status to CURRENT when a batch is assigned" do
    student = FactoryGirl.create(:student)
    batch = FactoryGirl.create(:batch)
    student.assign_batch(batch)
    student.status.should == 'CURRENT'
    student.batches.size.should == 1
  end

  it "should update the status to UNASSIGNED if there are not assigned batches" do
    student = FactoryGirl.create(:student)
    batch = FactoryGirl.create(:batch)
    student.assign_batch(batch)
    student.status.should == 'CURRENT'
    student.withdraw_from batch
    student.status.should == 'UNASSIGNED'
  end

  it "should not update the status to UNASSIGNED after a batch withdrawal if student belongs to other batches" do
    student = FactoryGirl.build(:student)
    batch1 = FactoryGirl.build(:batch)
    batch2 = FactoryGirl.build(:batch,:code=>'BT-FLG-02')
    batch3 = FactoryGirl.build(:batch,:code=>'BT-FLG-04')
    student.assign_batch(batch1)
    student.assign_batch(batch2)
    student.assign_batch(batch3)

    student.status.should == 'CURRENT'
    student.batches.size.should == 3

    student.withdraw_from batch2

    student.status.should == 'CURRENT'
    student.batches.size.should == 2

  end
end