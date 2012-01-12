class Batch < ActiveRecord::Base
  belongs_to :tutor
  belongs_to :course, :autosave=>true

  has_many :time_tables
  has_and_belongs_to_many :students, :uniq =>true, :autosave =>true

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

  def full?
    self.seats_available == 0
  end

  def validate_seat_count
    if self.errors[:total_seats].blank?
      if self.new_record?
        if self.total_seats > self.course.seats_remaining
          self.errors.add(:total_seats, 'cannot be more than total seats available for this course')
        else
          course.update_attributes(:seats_remaining => course.seats_remaining - total_seats)
          self.seats_available = self.total_seats if self.new_record?
        end
      end
    end
  end

  def validate_total_seats current_total_seats
    course_original_seats_remaining = self.course.seats_remaining + self.total_seats
    if current_total_seats > course_original_seats_remaining
      self.errors.add(:total_seats, 'cannot be more than total seats available for this course')
    end
  end

  def update_student_statuses
    self.students ||=[]
    self.students.each do |student|
      status = student.batches.size>1 ? 'CURRENT': 'UNASSIGNED'
      student.update_attributes(:status=> status)
      self.course.students.delete(student)
    end
    self.course.seats_remaining += total_seats
    self.course.save
  end

  def update_course_seats current_total_seats
    if self.total_seats != current_total_seats
      validate_total_seats current_total_seats
      if self.errors[:total_seats].blank?
        original_total_seats = self.total_seats
        original_available_seats = self.seats_available
        update = (original_total_seats - current_total_seats).abs
        if original_total_seats < current_total_seats
          if self.course.seats_remaining >= update
            self.course.update_attributes(:seats_remaining => course.seats_remaining - update )
            self.seats_available = original_available_seats + update
          else
            self.errors.add(:total_seats,"Not enough seats available for this update.")
          end
        elsif original_total_seats > current_total_seats
          self.course.update_attributes(:seats_remaining => course.seats_remaining + update )
          self.seats_available = original_available_seats - update
        end
      end
    end
    self.seats_available
  end

  def assign_student student
    self.students ||=[]
    unless full?
      self.students.push student
      self.course.enroll_student student
      self.seats_available -= 1
    else
      return false
    end
  end

end
