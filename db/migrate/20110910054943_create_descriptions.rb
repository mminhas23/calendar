class CreateDescriptions < ActiveRecord::Migration
  def self.up
    create_table :descriptions do |t|
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :descriptions
  end
end
