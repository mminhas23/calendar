class CreateStudentStatuses < ActiveRecord::Migration
  def self.up
    create_table :student_statuses do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :student_statuses
  end
end
