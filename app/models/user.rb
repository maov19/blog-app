class User < ApplicationRecord
  # has_secure_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy
  # validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end
  def update_posts_counter
    update(posts_counter: posts.count)
  end
  def admin?
    role == 'admin'
  end

  User.all.each do |user|
    puts "User ID: #{user.id}, Auth Token: #{user.attributes['auth_token']}"
  end
end