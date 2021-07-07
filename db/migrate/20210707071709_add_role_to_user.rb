class AddRoleToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role, :string, default: "general_user", null: false
    
    User.all.each do |user|
      user.update(role: "general_user")
    end
  end
end
