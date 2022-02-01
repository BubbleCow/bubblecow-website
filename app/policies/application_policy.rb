class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
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

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end

  private
  
  def is_staff?
    user.content_creator? || user.editor? || user.manager? || user.admin?
  end

  def is_editorial_staff?
    user.editor? || user.manager? || user.admin?
  end

  def is_marketing_staff?
    user.content_creator? || user.manager? || user.admin?
  end

  def is_managerial_staff?
    user.manager? || user.admin?
  end

  def is_owner?
    record.user
  end
  
end
