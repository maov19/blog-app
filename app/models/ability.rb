class Ability
    include CanCan::Ability
  
    def initialize(user)
      user ||= User.new # Guest user (not logged in)
      can :destroy, Post, author_id: user.id # User can delete their own posts
      can :destroy, Post, author_id: user.id if user.admin? # User with admin role can delete any post
    end
 end
  