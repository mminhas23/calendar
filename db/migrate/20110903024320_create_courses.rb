class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :name
      t.string :course_code
      t.date :start_date
      t.date :end_date
      t.integer :total_seats

      t.references :category

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
