require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('User')
      expect(association.options[:foreign_key]).to eq('author_id')
    end
  end

  describe 'callbacks' do
    let!(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
    let!(:post) { Post.new(author: user, title: 'First Post', text: 'Hello World') }
    let!(:comment) { Comment.new(post:, author: user, text: 'Great post!') }

    it 'updates post comments counter after create' do
      expect do
        comment.save
        post.reload
      end.to change(post, :comments_counter).by(1)
    end

    it 'updates post comments counter after destroy' do
      comment.save
      expect do
        comment.destroy
        post.reload
      end.to change(post, :comments_counter).by(-1)
    end
  end
end
