class CreateTutors < ActiveRecord::Migration
  def self.up
    create_table :tutors do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.date :dob
      t.string :contactNumber

      t.timestamps
    end
  end

  def self.down
    drop_table :tutors
  end
end
