class LessonPolicy < ApplicationPolicy
    
    def index?
		true
	end

	def show?
		true
	end

	def new?
		is_managerial_staff?
	end

	def create?
		is_managerial_staff?
	end

	def edit?
	    is_managerial_staff?
	end

	def update?
		is_managerial_staff?
	end

	def destroy?
		is_managerial_staff?
	end

end