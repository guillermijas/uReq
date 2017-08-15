class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.manager?
      can :create, Project
      can %i[read update], Project, user_projects: { user: user }
      can :destroy, Project, user_projects: { user: user, owner: true }
      can :manage, Requirement, project: { user_projects: { user: user } }
      can :manage, Comment, requierement: { project: { user_projects: { user: user } } }
      can :manage, Keyword
    else # colaborador
      can :read, Project, user_projects: { user: user }
      can :read, Requirement, project: { user_projects: { user: user } }
      can :create, Comment, requierement: { project: { user_projects: { user: user } } }
      can :destroy, Comment, user: user
      can :create, Keyword
    end
  end
end
