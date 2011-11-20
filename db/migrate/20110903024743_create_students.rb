class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :contact_number
      t.date :dob
      t.text :address

      t.string :student_type
      t.string :company_name
      t.string :company_address
      t.string :company_contact_name
      t.string :company_contact_number

      t.string :paymnet_method
      t.boolean :fee_received
      t.boolean :fee_processed
      t.boolean :docs_received
      t.boolean :docs_processed

      t.string :enrolled_by
      t.string :identifier

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
