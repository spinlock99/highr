class CreateHartmanValueProfiles < ActiveRecord::Migration
  def self.up
    create_table :hartman_value_profiles do |t|
      t.timestamp :taken_at
      t.integer :user_id

      t.timestamps
    end
    add_index :hartman_value_profiles, :user_id
  end

  def self.down
    drop_table :hartman_value_profiles
  end
end
