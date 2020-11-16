class ServicePricePolicy < ApplicationPolicy
    
    def index?
		# allow admin
		return true if user.present? && user.admin?
	end

	def show?
		# allow admin
		return true if user.present? && user.admin?
	end

	def new?
		# allow admin
		return true if user.present? && user.admin?
	end

	def create?
		# allow admin
		return true if user.present? && user.admin?
	end

	def edit?
	    update?
	end

	def update?
		# allow admin
		return true if user.present? && user.admin?
	end

	def destroy?
		# allow admin
		return true if user.present? && user.admin?
	end

	private

	def post
		record
	end
end