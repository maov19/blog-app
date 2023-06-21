class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :destroy, Post, author_id: user.id
    can :destroy, Comment, author_id: user.id
    can :destroy, Post, author_id: user.id if user.admin?
    can :destroy, Comment, author_id: user.id if user.admin?
  end
end