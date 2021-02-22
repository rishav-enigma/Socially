class Ability
  include CanCan::Ability
  
  def initialize(user)
    can :read, Post, visibility: 2
    can :read, User
    if user.present?
      [Post, Comment, Like].each do |model|
        can :manage, model,  user_id: user.id
      end
      can :manage, User, id: user.id
    end
  end
end
