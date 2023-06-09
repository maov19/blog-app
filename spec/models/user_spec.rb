require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires a name' do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'validates numericality of posts_counter' do
      user = User.new(posts_counter: 'invalid')
      user.valid?
      expect(user.errors[:posts_counter]).to include('is not a number')
    end

    it 'validates posts_counter is greater than or equal to 0' do
      user = User.new(posts_counter: -1)
      user.valid?
      expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
    end
  end

  describe 'methods' do
    let!(:user) do
      User.create(
        name: 'Tom',
        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
        bio: 'Teacher from Mexico.'
      )
    end
    let!(:post_one) { user.posts.create(title: 'First Post', text: 'Hello World') }
    let!(:post_two) { user.posts.create(title: 'Second Post', text: 'Hello World') }
    let!(:post_three) { user.posts.create(title: 'Third Post', text: 'Hello World') }
    let!(:post_four) { user.posts.create(title: 'Fourth Post', text: 'Hello World') }
    let!(:posts) { [post_one, post_two, post_three, post_four] }

    it 'returns recent posts' do
      recent_posts = user.recent_posts

      expect(recent_posts.length).to eq(3)
      expect(recent_posts).to all(be_a(Post))
    end

    it 'updates posts counter' do
      allow(user).to receive(:posts).and_return(posts)
      expect do
        user.update_posts_counter
        user.reload
      end.to change(user, :posts_counter).to(4)
    end
  end
end
