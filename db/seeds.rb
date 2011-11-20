# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

slots = Description.create([{:description => '8AM to 10AM'}, {:description => '10AM to 12AM'}, {:description => '1PM to 3PM'}, {:description => '3PM to 5 PM'}, {:description => '5PM to 7PM'}])
week_days = WeekDay.create([{:name => 'Monday'}, {:name => 'Tuesday'}, {:name => 'Wednesday'}, {:name => 'Thursday'}, {:name => 'Friday'}, {:name => 'Saturday'}, {:name => 'Sunday'}])
payment_methods = PaymentMethod.create([{:description => 'Visa'},{:description => 'Mastercard'},{:description => 'Cash'}, {:description => 'Cheque'}, {:description => 'Direct Debit'}, {:description => 'Draft'},{:description => 'Paypal'}])
student_types = StudentType.create([{:description => 'International'}, {:description => 'Type_1'}, {:description => 'Type_3'}])