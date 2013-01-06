class Ability
  include CanCan::Ability

  def initialize(user)
    guest do
      can :read, Artwork
      can :read, Gallery
      can :read, Resource
      can :read, User
    end

    any_user(user) do |user|
      can :create, Gallery
      can :manage, Gallery, :user_id => user.id
      can :manage, User, :id => user.id
    end

    any_admin(user) do |user|
      can :manage, Artwork
      can :manage, Gallery
      can :manage, Settings
      can :manage, Resource
      can :manage, User
    end
  end
end

def guest
  yield
end

def any_user(user)
  yield(user) if user
end

def any_admin(user)
  yield(user) if user && user.admin?
end
