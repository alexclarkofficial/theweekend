class AddIndexWeekendsDate < ActiveRecord::Migration
  def change
    add_index :weekends, :week
  end
end
