class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :name
      t.date :dob
      t.text :address
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
