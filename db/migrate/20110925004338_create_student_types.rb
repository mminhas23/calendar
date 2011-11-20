class CreateStudentTypes < ActiveRecord::Migration
  def self.up
    create_table :student_types do |t|
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :student_types
  end
end
