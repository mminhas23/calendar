require 'date'

class Course < ActiveRecord::Base
  belongs_to :category
  has_many :batches, :dependent => :destroy, :autosave => true

  has_and_belongs_to_many :students, :uniq => true , :autosave =>true
  validates_presence_of :name, :course_code, :total_seats
  validates_uniqueness_of :category_id, :scope => [:name, :course_code], :message => 'already has a course with this name/code'

  validates :start_date, :presence => true, :course_start_date=>true
  validates :end_date, :presence => true, :course_end_date=>true

  def batches_available
    available_batches = []
    self.batches ||= []
    self.batches.each do |batch|
      available_batches.push batch unless batch.full?
    end
    available_batches
  end

  def full?
    self.seats_remaining == 0
  end

  def allocate_batch batch
    self.batches ||= []
    if batch.total_seats > self.seats_remaining
      batch.errors[:base] << "Course is full. Cannot allocate another Batch."
      return false
    else
      self.seats_remaining -= batch.total_seats
      self.batches.push batch
      return true
    end
  end

  def enroll_student student
    self.students ||=[]
    self.students.push student
    student.update_status
  end

  def enrolled_student_ids
    enrolled_students = []
    self.batches ||= []
    self.batches.each do |batch|
      batch.students.each do |student|
        enrolled_students.push student.id
      end
    end
    enrolled_students
  end

  def update_remaining_seats previous_seat_count, new_seat_count
    if full?
      if previous_seat_count > new_seat_count
        self.errors.add(:total_seats, "You cannot reduce the seat count now. Course is full")
        return
      else
        self.seats_remaining += (new_seat_count-previous_seat_count)
      end
    else
      if previous_seat_count > new_seat_count
        update = previous_seat_count - new_seat_count
        if update > self.seats_remaining
          self.errors.add(:total_seats, "Unable to reduce the number of seats. You can reduce it only by the number of seats remaining, which is #{self.seats_remaining}")
          return
        else
          self.seats_remaining += update
        end
      else
        self.seats_remaining += (new_seat_count-previous_seat_count)
      end
    end
    self.seats_remaining
  end
end
