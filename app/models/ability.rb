class Ability
  include CanCan::Ability

  def initialize user
    can :read, %i(Book Author)

    return if user.blank?

    can %i(read update), User, id: user.id
    can :create, Request
    can %i(read update), Request, user: user
    can %i(read create destroy), :cart

    return unless user.admin?

    can %i(read update), Request
  end
end
