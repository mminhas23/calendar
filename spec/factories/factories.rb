FactoryGirl.define do

  factory :category do
    code 'TST'
    description 'Test Category'
  end

  factory :course do
    name 'Foreign Language'
    course_code  'CR-FLG-01'
    start_date '2011-12-12'
    end_date '2012-12-12'
    total_seats 100
    association :category
  end
end