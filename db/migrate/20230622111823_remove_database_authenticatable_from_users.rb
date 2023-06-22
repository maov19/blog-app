# frozen_string_literal: true

class RemoveDatabaseAuthenticatableFromUsers < ActiveRecord::Migration[7.0]
  def up
    remove_column :users, :email, :string
    remove_column :users, :encrypted_password, :string
  end

  def down
    add_column :users, :email, :string, null: false, default: ""
    add_column :users, :encrypted_password, :string, null: false, default: ""
  end
end
