class AddPhraseToHvpElement < ActiveRecord::Migration
  def self.up
    add_column :hvp_elements, :phrase, :string
  end

  def self.down
    remove_column :hvp_elements, :phrase, :string
  end
end
