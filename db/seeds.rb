User.delete_all
Role.delete_all
Message.delete_all
Comment.delete_all

admin = User.create(
  username: 'admin',
  full_name: 'Admin',
  email: 'admin@example.com',
  password: '12345678'
)

moderator = User.create(
  username: 'moderator',
  full_name: 'Moderator',
  email: 'moderator@example.com',
  password: '12345678'
)

user = User.create(
  username: 'user',
  full_name: 'User',
  email: 'user@example.com',
  password: '12345678'
)

admin.add_role(:admin)
moderator.add_role(:moderator)
user.add_role(:user)
