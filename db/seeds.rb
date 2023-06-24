user = User.find_or_create_by(
  name: 'Sam Smith',
  photo: 'https://icons.iconarchive.com/icons/iconsmind/outline/256/User-icon.png',
  bio: 'Teacher from Poland.',
  posts_counter: 0
)

Post.find_or_create_by(
  author: user,
  title: 'Test Post',
  text: 'This is my first test post',
  comments_counter: 0,
  likes_counter: 0
)
