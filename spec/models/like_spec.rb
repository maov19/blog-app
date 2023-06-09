require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'methods' do
    let!(:user) do
        User.create(
          name: 'Tom',
          photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
          bio: 'Teacher from Mexico.',
          posts_counter: 1
        )
    end
    
    let!(:post) { user.posts.create(title: 'First Post', text: 'Hello World')} 
    let!(:like) { Like.create(author: user, post: post)}
  
    it 'updates post likes counter after create' do
      expect {
        Like.create(author: user, post: post)
      }.to change(post, :likes_counter).by(1)
    end

    it 'updates post likes counter after destroy' do
      expect {
        like.destroy
        post.reload
      }.to change(post, :likes_counter).by(-1)
    end
  end
end
