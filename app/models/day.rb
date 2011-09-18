class Day < ActiveRecord::Base
  has_many :slots
  belongs_to :time_table
  accepts_nested_attributes_for :slots, :reject_if => lambda { |a| a[:description].blank? }, :allow_destroy => true
end
