class AddTotalSeatsAndSeatsRemainingToBatches < ActiveRecord::Migration
  def self.up
    add_column :batches, :total_seats, :integer
    add_column :batches, :seats_available, :integer
  end

  def self.down
    remove_column :batches, :seats_available
    remove_column :batches, :total_seats
  end
end
