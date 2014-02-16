class AddVotesCountToWeekends < ActiveRecord::Migration
  def change
    add_column :weekends, :votes_count, :integer, default: 0

    Weekend.reset_column_information
    Weekend.find_each do |we|
      we.update_attribute :votes_count, we.votes.length
    end
  end
end
