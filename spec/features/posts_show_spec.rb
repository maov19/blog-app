require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  before do
    @user1 = User.create(name: 'Sam', photo: 'https://icons.iconarchive.com/icons/iconsmind/outline/256/User-icon.png',
                         bio: 'Teacher from Poland.', posts_counter: 0)
    @post = Post.create(author: @user1, title: 'Test Post', text: 'This is my first test post', comments_counter: 0,
                        likes_counter: 0)
    @comment1 = Comment.create(post: @post, author: @user1, text: 'Hi Tom!, Nice comment')
    visit user_posts_path(@user1)
  end

  scenario 'I can see the username, profile picture, and number of posts for each user' do
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(/#{@post.title}/i)
    expect(page).to have_content(@post.text)
    expect(page.html).to include(@user1.photo)
    expect(page).to have_content(@user1.posts_counter)
    expect(page).to have_content(@post.likes_counter)
    expect(page).to have_content(@post.comments_counter)
    expect(page).to have_content(@user1.name, count: 2) # Ensure commenters' username is displayed
  end

  scenario 'When I click on a user, I am redirected to their show page' do
    click_on @user1.name
    expect(current_path).to eq(user_path(@user1))
  end
end
