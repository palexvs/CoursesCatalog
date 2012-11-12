class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all

      can :manage, TrackIt, :user_id => user.id
    elsif user.user?
      can :read, Course, :publish_status => "publish"
      can :manage, Course, :publish_status => "draft", :created_by => user.id
      can [:read, :create], Course, :publish_status => "pending", :created_by => user.id

      cannot :publish, Course

      can :read, StartDate, :publish_status => "publish"
      can :manage, StartDate, :publish_status => "draft", :created_by => user.id
      can [:read, :create], StartDate, :publish_status => "pending", :created_by => user.id

      cannot :publish, StartDate      

      can :manage, TrackIt, :user_id => user.id
    else
      can :read, Course, :publish_status => "publish"
    end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
