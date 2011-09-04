class CoursesStudents < ActiveRecord::Migration
  def self.up
    create_table :courses_students, :id => false do |t|
      t.integer :course_id
      t.integer :student_id
    end

    add_index :courses_students, [:course_id, :student_id], :name =>"by_course_student" , :unique => true

  end

  def self.down
    remove_index :courses_students, :name => :by_course_student
    drop_table :courses_students
  end
end
