class PostCategoryPolicy < ApplicationPolicy
    
    def index?
		is_marketing_staff
	end

	def show?
		true
	end

	def new?
		is_marketing_staff
	end

	def create?
		is_marketing_staff
	end

	def edit?
	    update?
	end

	def update?
		is_marketing_staff
	end

	def destroy?
		is_marketing_staff
	end

end