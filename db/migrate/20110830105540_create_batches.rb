class CreateBatches < ActiveRecord::Migration
  def self.up
    create_table :batches do |t|
      t.string :code
      t.references :tutor
      t.references :course

      t.timestamps
    end
  end

  def self.down
    drop_table :batches
  end
end
