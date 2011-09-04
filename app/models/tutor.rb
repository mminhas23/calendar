class Tutor < ActiveRecord::Base
 has_many :time_slots
 has_many :batches, :through => :time_slots
end
