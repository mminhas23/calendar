class Course < ActiveRecord::Base
  belongs_to :category
  has_many :batches, :dependent => :destroy
  accepts_nested_attributes_for :batches, :reject_if => lambda {|a| a[:code].blank?}, :allow_destroy => true
  has_and_belongs_to_many :students, :uniq => true
end
