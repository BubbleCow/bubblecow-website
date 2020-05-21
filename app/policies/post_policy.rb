class PostPolicy < ApplicationPolicy
    
    def index?
		true
	end

	def show?
		true
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