class PostAuthorPolicy < ApplicationPolicy
    
    def index?
		return true if user.present? && user.admin?
	end

	def show?
		true
	end

	def new?
		return true if user.present? && user.admin?
	end

	def create?
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