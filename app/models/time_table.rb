class TimeTable < ActiveRecord::Base
  belongs_to :tutor
  belongs_to :batch
  has_many :days, :dependent => :destroy
  accepts_nested_attributes_for :days, :reject_if => lambda { |a| a[:day].blank? }, :allow_destroy => true

  def tutorName
    tutor = Tutor.find(self.tutor)
    tutor.firstName + " " + tutor.lastName
  end

  def batchCode
    batch = Batch.find(self.batch)
    batch.code
  end
end
