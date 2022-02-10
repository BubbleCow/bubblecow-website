class UserPolicy < ApplicationPolicy

	def index?
		is_managerial_staff?
	end

	def show?
		is_managerial_staff?
	end

	def edit?
	    update?
	end

	def update?
		true
	end

	def destroy?
		true
	end

end