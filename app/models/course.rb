require 'date'

class Course < ActiveRecord::Base
  belongs_to :category
  has_many :batches, :dependent => :destroy
  accepts_nested_attributes_for :batches, :reject_if => lambda {|a| a[:code].blank?}, :allow_destroy => true
  has_and_belongs_to_many :students, :uniq => true

  validates_presence_of :name, :course_code, :total_seats
  validates_uniqueness_of :category_id, :scope => [:name, :course_code]

  validates :start_date, :presence => true, :course_start_date=>true
  validates :end_date, :presence => true, :course_end_date=>true
end
