class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :moderator
      can :manage, Message
      can :manage, Comment
      can :read, User
    elsif user.has_role? :user
      can :manage, Message do |message|
        message.try(:user) == user
      end
      can :manage, Comment  do |comment|
        comment.try(:user) == user
      end

      can [:index, :read], User

      can :manage, User

      can :read, Message
      can :create, Message

      can :read, Comment
      can :create, Comment

      cannot :manage, Role
    else
      can :read, :all
    end
  end
end
