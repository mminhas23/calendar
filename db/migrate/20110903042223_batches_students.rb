class BatchesStudents < ActiveRecord::Migration
  def self.up
    create_table :batches_students, :id => false do |t|
      t.integer :batch_id
      t.integer :student_id
    end
    add_index(:batches_students, [:batch_id, :student_id], :name => "by_batch_student", :unique => true)
  end

  def self.down
    remove_index :batches_students, :name => :by_batch_student
    drop_table :batches_students
  end
end
