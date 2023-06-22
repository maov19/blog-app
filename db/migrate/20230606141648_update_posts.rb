class UpdatePosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :author_id
    add_reference :posts, :author, foreign_key: { to_table: :users }
    add_index :posts, :author_id, unique: true, if_not_exists: true
  end
end
