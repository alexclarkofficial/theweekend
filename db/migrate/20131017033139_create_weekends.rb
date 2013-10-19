class CreateWeekends < ActiveRecord::Migration
  def change
    create_table :weekends do |t|
      t.date :week
      t.integer :user_id

      t.timestamps
    end
    add_index :weekends, [:user_id, :created_at]
  end
end
