require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before do
    @user1 = User.create(name: 'John Doe')
    @user2 = User.create(name: 'Jane Smith')

    #update profile pictures
    @user1.update(photo: 'https://unsplash.com/photos/F_-0BxGuVvo')
    @user2.update(photo: 'https://unsplash.com/es/fotos/mEZ3PoFGs_k')

    # Update posts_counter for user1
    @user1.update(posts_counter: 5)

    # Update posts_counter for user2
    @user2.update(posts_counter: 10)
  end

  it 'displays the username of all other users' do
    visit users_path

    expect(page).to have_content('John Doe')
    expect(page).to have_content('Jane Smith')
  end

  it 'displays the profile picture for each user' do
    visit users_path

    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
    expect(page).to have_css("img[src*='https://unsplash.com/es/fotos/mEZ3PoFGs_k']")
  end

  it 'displays the number of posts each user has written' do
    visit users_path

    expect(page).to have_content('Posts: 5', count: 1)
    expect(page).to have_content('Posts: 10', count: 1)
  end

  it 'redirects to the user show page when clicking on a user' do
    visit users_path

    click_link @user1.name

    expect(current_path).to eq(user_path(@user1))
    expect(page).to have_content(@user1.name)
    expect(page).to have_content('Posts: 5')
  end
end
