class ApplicationPolicy
  attr_reader :current_user, :target

  def initialize(current_user, target)
    @current_user = current_user
    @target = target
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
