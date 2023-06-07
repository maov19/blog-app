class UpdateComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :author_id
    remove_column :comments, :post_id

    add_reference :comments, :author, foreign_key: { to_table: :users }
    add_reference :comments, :post, foreign_key: true

    add_index :comments, :author_id, unique: true, if_not_exists: true
    add_index :comments, :post_id, unique: true, if_not_exists: true
  end
end
