class Tutor < ActiveRecord::Base
 has_one :time_table
 accepts_nested_attributes_for :time_table
# has_many :batches, :through => :time_tables
end
