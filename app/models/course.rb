class Course < ActiveRecord::Base
  belongs_to :category
  has_many :batches, :dependent => :destroy
  has_and_belongs_to_many :students, :uniq => true
end
