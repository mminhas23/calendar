class RenameColumnNameForStudents < ActiveRecord::Migration
  def self.up
    rename_column :students, :paymnet_method, :payment_method
  end

  def self.down
    rename_column :students, :payment_method , :paymnet_method
  end
end
