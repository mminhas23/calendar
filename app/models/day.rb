class Day < ActiveRecord::Base
  has_many :sessions
  belongs_to :time_table
  accepts_nested_attributes_for :sessions, :reject_if => lambda { |a| a[:description].blank? }, :allow_destroy => true
end
