class Batch < ActiveRecord::Base
  belongs_to :tutor
  belongs_to :course
  has_many :time_tables
  has_and_belongs_to_many :students, :uniq =>true

  validates_presence_of :code, :total_seats
  validate :validate_seat_count

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

  def isBatchFull?
    self.seats_available = 0    
  end

  def validate_seat_count
    if self.errors[:total_seats].blank?
      if self.total_seats > self.course.total_seats
        self.errors.add(:total_seats, 'cannot be more than total seats available for this course')
      end
    end
  end
end
