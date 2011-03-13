class ChangeUsersForAuthlogic < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.rename :name, :username
      t.rename :encrypted_password, :crypted_password
      t.rename :salt, :password_salt
      t.string :persistence_token
    end
  end

  def self.down
    change_table :users do |t|
      t.rename :username, :name
      t.rename :crypted_password, :encrypted_password
      t.rename :password_salt, :salt
     end
    remove_column :users , :persistence_token
  end
end
