class RemoveTagFromTask < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :tag
  end
end
