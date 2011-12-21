class AddSeatsRemainingToCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :seats_remaining, :integer
  end

  def self.down
    remove_column :courses, :seats_remaining
  end
end
