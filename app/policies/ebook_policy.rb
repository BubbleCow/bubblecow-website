class EbookPolicy < ApplicationPolicy
    
    def index?
		true
	end

	def show?
		true
	end

	def new?
		is_editorial_staff?
	end

	def create?
		is_editorial_staff?
	end

	def edit?
	    update?
	end

	def update?
		is_editorial_staff?
	end

	def destroy?
		is_managerial_staff?
	end

end