class Student < ActiveRecord::Base
  has_and_belongs_to_many :courses, :uniq => true
  has_and_belongs_to_many :batches, :uniq => true
  has_many :comments, :dependent => :destroy
  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  def course_categories
    categories = Array.new
    if !self.courses.empty?
      self.courses.each do |course|
        categories.push(course.category_id)
      end
    end
    categories
  end
end
