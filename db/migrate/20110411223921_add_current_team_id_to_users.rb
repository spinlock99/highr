class AddCurrentTeamIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :current_team_id, :integer
  end

  def self.down
    remove_column :users, :current_team_id
  end
end
