require 'active_support/secure_random'
class Student < ActiveRecord::Base
  before_create :assign_unique_identifier

  has_and_belongs_to_many :courses, :uniq => true
  has_and_belongs_to_many :batches, :uniq => true
  has_many :comments, :dependent => :destroy

  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  validates_presence_of :first_name, :last_name, :email, :contact_number, :dob, :address, :payment_method
  validates_presence_of  :company_name,  :company_address, :company_contact_name, :company_contact_number, :if=>:type3?

  scope :with_status, lambda {|status| where("status = ?", status)}
  scope :current_unassigned, lambda { where("status IN ('CURRENT', 'UNASSIGNED')") }

  def assign_unique_identifier
    self.identifier = ActiveSupport::SecureRandom.urlsafe_base64(8)
  end

  def type3?
    self.student_type == 'Type_3'
  end

  def payment_methods options
      self.payment_method = options.join(",") unless options.nil?
  end

  def assign_batch batch
    self.batches ||=[]
    self.batches.push batch
    batch.update_attributes(:seats_available => batch.seats_available-1)
    self.status = 'CURRENT'
  end

  def assign_course course
    self.courses ||=[]
    self.courses.push course
  end

  def assign course, batch
    assign_batch batch
    assign_course course
    self
  end

  def withdraw_from batch
    self.batches.delete(batch)
    update_status
  end

  def update_status
    self.status = self.batches.empty? ?  'UNASSIGNED' : 'CURRENT'
  end
end
