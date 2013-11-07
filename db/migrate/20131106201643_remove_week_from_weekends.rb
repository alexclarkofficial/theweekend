class RemoveWeekFromWeekends < ActiveRecord::Migration
  def change
    change_table :weekends do |t|
      t.remove :week
      t.integer :week_id
    end
  end
end
