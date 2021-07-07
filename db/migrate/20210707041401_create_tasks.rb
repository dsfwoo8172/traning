class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title
      t.datetime :start_time
      t.datetime :end_time
      t.string :order, default: "low"
      t.string :state, default: "pending"
      t.string :tag

      t.timestamps
    end
  end
end
