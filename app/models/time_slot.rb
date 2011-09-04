class TimeSlot < ActiveRecord::Base
  belongs_to :tutor
  belongs_to :batch
end
