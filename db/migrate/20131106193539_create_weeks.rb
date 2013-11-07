class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.date :date

      t.timestamps
    end
    add_index :weeks, :date, unique: true
  end
end
