class AddVotesCountToWeekends < ActiveRecord::Migration
  def change
    add_column :weekends, :votes_count, :integer, default: 0
  end
end
