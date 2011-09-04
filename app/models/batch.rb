class Batch < ActiveRecord::Base
  belongs_to :tutor
  belongs_to :course
  has_many :time_slots
  has_and_belongs_to_many :students, :uniq =>true
end
