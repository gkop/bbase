class Ability
  include CanCan::Ability

  def initialize(user)
    guest do
      can :read, Artwork
      can :read, Exhibition 
      can :read, User
    end

    any_user(user) do |user|
      can :create, Exhibition
      can(:manage, Exhibition) { |e| e.user == user }
      can(:manage, User) { |u| u == user }
    end

    any_admin(user) do |user|
      can :manage, Artwork
      can :manage, Exhibition
      can :manage, Settings
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
