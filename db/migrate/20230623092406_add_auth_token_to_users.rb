class AddAuthTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :auth_token, :string
    add_index :users, :auth_token, unique: true

    User.all.each do |user|
      user.update(auth_token: generate_auth_token)
    end
  end

  private

  def generate_auth_token
    SecureRandom.base58(24)
  end
end
