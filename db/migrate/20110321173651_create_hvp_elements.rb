class CreateHvpElements < ActiveRecord::Migration
  def self.up
    create_table :hvp_elements do |t|
      t.integer :axiological_norm
      t.integer :given_value
      t.string :part_id
      t.string :category_id
      t.integer :hartman_value_profile_id

      t.timestamps
    end
    add_index :hvp_elements, :hartman_value_profile_id
  end

  def self.down
    drop_table :hvp_elements
  end
end
