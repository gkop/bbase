class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :manage, Artwork
  end
end
