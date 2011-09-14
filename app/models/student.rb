class Student < ActiveRecord::Base
  has_and_belongs_to_many :courses, :uniq => true
  has_and_belongs_to_many :batches, :uniq => true
end
