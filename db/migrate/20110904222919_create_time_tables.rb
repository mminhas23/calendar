class CreateTimeTables < ActiveRecord::Migration
  def self.up
    create_table :time_tables do |t|
      t.references :tutor
      t.references :batch

      t.timestamps
    end
  end

  def self.down
    drop_table :time_tables
  end
end
