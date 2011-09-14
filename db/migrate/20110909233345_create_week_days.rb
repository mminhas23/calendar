class CreateWeekDays < ActiveRecord::Migration
  def self.up
    create_table :week_days do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :week_days
  end
end
