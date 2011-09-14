class CreateDays < ActiveRecord::Migration
  def self.up
    create_table :days do |t|
      t.string :day
      t.references :time_table

      t.timestamps
    end
  end

  def self.down
    drop_table :days
  end
end
