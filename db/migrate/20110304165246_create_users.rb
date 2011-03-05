#Auto generated migration file that rolls the database
#forward to add a user table with name and email columns.
class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
