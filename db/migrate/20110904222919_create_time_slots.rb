class CreateTimeSlots < ActiveRecord::Migration
  def self.up
    create_table :time_slots do |t|
      t.date :date
      t.string :day
      t.string :slot
      t.references :tutor
      t.references :batch

      t.timestamps
    end
  end

  def self.down
    drop_table :time_slots
  end
end
