class ChangeColToTask < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :order, :string
    remove_column :tasks, :state, :string
    add_column :tasks, :order, :integer
    add_column :tasks, :state, :integer
  end
end
