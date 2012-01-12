require 'date'
FactoryGirl.define do

  factory :category do
    code 'TST'
    description 'Test Category'
  end

  factory :course do
    name 'Foreign Language'
    course_code  'CR-FLG-01'
    start_date {DateTime.now.to_date}
    end_date '2012-12-12'
    total_seats 100
    seats_remaining 100
    association :category, :method => :build
  end

  factory :student do
    first_name 'Manpreet'
    last_name 'Minhas'
    email 'mminhas23@gmail.com'
    contact_number '0400 689 950'
    dob '1979-12-23'
    address '7 Mayesbrook Road'
    payment_method 'VISA'
    status 'UNASSIGNED'
  end

  factory :batch do
    code 'BT-FLG-01'
    total_seats 20
    seats_available 20
    association :course, :method => :build
  end

end