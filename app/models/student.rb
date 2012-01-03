require 'active_support/secure_random'
class Student < ActiveRecord::Base
  before_create :assign_unique_identifier

  has_and_belongs_to_many :courses, :uniq => true
  has_and_belongs_to_many :batches, :uniq => true
  has_many :comments, :dependent => :destroy

  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  validates_presence_of :first_name, :last_name, :email, :contact_number, :dob, :address, :payment_method
  validates_presence_of  :company_name,  :company_address, :company_contact_name, :company_contact_number, :if=>:type3?

  def assign_unique_identifier
    self.identifier = ActiveSupport::SecureRandom.urlsafe_base64(8)
  end

  def type3?
    self.student_type == 'Type_3'
  end

  def payment_methods options
      self.payment_method = options.join(",") unless options.nil?
  end

  def update_batches batch_ids
    for batch in Batch.where(:id => batch_ids)
        Batch.update(batch.id,:seats_available => batch.seats_available - 1)
    end
    self.batches = batch_ids
  end

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
