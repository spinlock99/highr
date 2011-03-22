class CreateHvpMasters < ActiveRecord::Migration
  def self.up
    create_table :hvp_masters do |t|
      t.integer :axiological_norm
      t.string :part_id
      t.string :category_id
      t.string :phrase

      t.timestamps
    end
  end

  def self.down
    drop_table :hvp_masters
  end
end
