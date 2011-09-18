class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all if user.role == "admin"
    can :assign_roles, User if user.admin?

    cannot :index, User if user.manager?
  end
end
