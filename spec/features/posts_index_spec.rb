require 'rails_helper'

RSpec.describe 'Post Index Page', type: :feature do
  describe 'Viewing Post Index page' do
    before(:each) do
      @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.',
                           posts_counter: 6)
      @first_post = Post.create(author: @user1, title: 'post1', text: 'This is my first post', likes_counter: 0,
                                comments_counter: 1)
      @second_post = Post.create(author: @user1, title: 'post1', text: 'This is my second post', likes_counter: 0,
                                 comments_counter: 1)
      @third_post = Post.create(author: @user1, title: 'post1', text: 'This is my third post', likes_counter: 0,
                                comments_counter: 1)
      @fourth_post = Post.create(author: @user1, title: 'post1', text: 'This is my fourth post', likes_counter: 0,
                                 comments_counter: 1)
      @fifth_post = Post.create(author: @user1, title: 'post1', text: 'This is my fifth post', likes_counter: 0,
                                comments_counter: 1)
      @sixth_post = Post.create(author: @user1, title: 'post1', text: 'This is my sixth post', likes_counter: 0,
                                comments_counter: 1)

      @comment1 = Comment.create(post: @first_post, author: @user1, text: 'Hi Tom!, Nice comment')
      visit user_posts_path(@user1)
    end

    it 'should show user name' do
      expect(page).to have_content(@user1.name)
    end

    it 'should show user photo' do
      expect(page.html).to include(@user1.photo)
    end

    it 'should show posts_counter of clicked user' do
      expect(page).to have_content(@user1.posts_counter)
    end

    it 'should show all posts' do
      expect(page).to have_content(@first_post.text)
    end

    it 'should show post text' do
      expect(page).to have_content(@first_post.text)
    end

    it 'should show comment text' do
      expect(page).to have_content(@first_post.text)
    end

    it 'should show comments counter' do
      expect(page).to have_content(@first_post.comments_counter)
    end

    it 'should show likes counter' do
      expect(page).to have_content(@first_post.likes_counter)
    end

    it 'should navigate to post show page when clicked on post' do
      find('a', text: @first_post.text).click
      expect(current_path).to eq(user_post_path(@first_post.author_id, @first_post))
    end

    it 'should show a button for pagination if there are more posts than fit on the view.' do
      visit user_posts_path(@user1.id)
      expect(page).to have_button('Pagination')
    end
  end
end
