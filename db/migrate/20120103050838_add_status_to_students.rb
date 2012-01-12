class AddStatusToStudents < ActiveRecord::Migration
  def self.up
    add_column :students, :status, :string
  end

  def self.down
    remove_column :students, :status
  end
end
