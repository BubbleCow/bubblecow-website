class MessagePolicy < ApplicationPolicy
    
    def index?
		# allow admin
		return true if user.present? && user.admin?
	end

	def show?
		# allow admin
		return true if user.present? && user.admin?
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