class UpdateLikes < ActiveRecord::Migration[7.0]
  def change
    # remove_column :likes, :author_id
    # remove_column :likes, :post_id

    add_reference :likes, :author, foreign_key: { to_table: :users }
    add_reference :likes, :post, foreign_key: true

    add_index :likes, :author_id, unique: true, if_not_exists: true
    add_index :likes, :post_id, unique: true, if_not_exists: true
  end
end
