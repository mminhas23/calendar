class Batch < ActiveRecord::Base
  belongs_to :tutor
  belongs_to :course
  has_many :time_tables
  has_and_belongs_to_many :students, :uniq =>true

  def tutorName
    if self.tutor!=nil
      tutor = Tutor.find(self.tutor)
      tutor.firstName + " " + tutor.lastName
    else
      "Not assigned"
    end
  end

  def courseCode
    course = Course.find(self.course)
    course.course_code
  end
end
