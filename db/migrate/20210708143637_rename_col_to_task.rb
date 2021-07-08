class RenameColToTask < ActiveRecord::Migration[6.1]
  def change
    rename_column :tasks, :order, :priority
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
