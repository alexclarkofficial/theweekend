class AddWeekendIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :weekend_id, :integer
  end
end
