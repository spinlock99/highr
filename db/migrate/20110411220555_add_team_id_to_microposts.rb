class AddTeamIdToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :team_id, :integer
  end

  def self.down
    remove_column :microposts, :team_id
  end
end
