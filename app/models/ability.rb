class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
      cannot :destroy, User, id: user.id
    elsif user.user?
      can :read, :all
      can :manage, Suggest, user_id: user.id
      can :manage, Review, user_id: user.id
      can :manage, Comment, user_id: user.id
      can [:create, :destroy], Favorite
      can :findfavorite, Book
      can [:following, :followers], User
    else
      can :read, Book
      can :read, Category
    end
  end
end
