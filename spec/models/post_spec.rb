require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'requires a title' do
      post = Post.new(title: nil)
      post.valid?
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'validates the maximum length of title' do
      post = Post.new(title: 'a' * 251)
      post.valid?
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'validates numericality of comments_counter' do
      post = Post.new(comments_counter: 'invalid')
      post.valid?
      expect(post.errors[:comments_counter]).to include('is not a number')
    end

    it 'validates comments_counter is greater than or equal to 0' do
      post = Post.new(comments_counter: -1)
      post.valid?
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end

    it 'validates numericality of likes_counter' do
      post = Post.new(likes_counter: 'invalid')
      post.valid?
      expect(post.errors[:likes_counter]).to include('is not a number')
    end

    it 'validates likes_counter is greater than or equal to 0' do
      post = Post.new(likes_counter: -1)
      post.valid?
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
    end
  end

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

    it 'updates user posts counter after destroy' do
      post.save
      expect {
        post.destroy
        user.reload
      }.to change(user, :posts_counter).by(-1)
    end

    it 'returns recent comments' do
      comments = []
      5.times do |i|
        comments << post.comments.create(post: post, author: user, text: "Comment #{i + 1}")
      end
  
      recent_comments = post.recent_comments
      expect(recent_comments.length).to eq(5)
      expect(recent_comments).to all(be_a(Comment))
    end
  end
end
