class UserPolicy < ApplicationPolicy

	def index?
		# is_managerial_staff?
		true
	end

	def show?
		# is_managerial_staff?
		true?
	end

	def edit?
	    update?
	end

	def update?
		# is_managerial_staff?
		true
	end

	def destroy?
		# is_managerial_staff?
		true
	end

end