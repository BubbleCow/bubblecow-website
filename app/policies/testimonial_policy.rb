class TestimonialPolicy < ApplicationPolicy
    
    def index?
		true
	end

	def show?
		false
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
		is_owner? | is_managerial_staff?
	end

	def destroy?
		is_managerial_staff?
	end

end