class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :manage, Artwork
    can :manage, Exhibition
  end
end
