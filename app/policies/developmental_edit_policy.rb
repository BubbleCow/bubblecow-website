class DevelopmentalEditPolicy < ApplicationPolicy


	def index?
		user.developmental_edits || is_editorial_staff?
	end

	def show?
		is_owner? || is_editorial_staff?
	end

	def new?
		true
	end

	def create?
		true
	end

	def edit?
	    update?
	end

	def update?
		is_owner? || is_editorial_staff?
	end

	def destroy?
		is_managerial_staff?
	end

end
