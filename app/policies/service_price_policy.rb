class ServicePricePolicy < ApplicationPolicy
    
    def index?
		is_managerial_staff?
	end

	def show?
		is_managerial_staff?
	end

	def new?
		is_managerial_staff?
	end

	def create?
		is_managerial_staff?
	end

	def edit?
	    update?
	end

	def update?
		is_managerial_staff?
	end

	def destroy?
		is_managerial_staff?
	end

end