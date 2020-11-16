class DevelopmentalEditPolicy < ApplicationPolicy

	def index?
		# allow admin
		return true if user.present? && user.admin?
	end

	def show?
		# allow admin
		return true if user.present? && user.admin?

		# allow writer to only see own post
		user.present? && user == developmental_edit.user
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

		# allow writer to only see own post
		user.present? && user == developmental_edit.user
	end

	def destroy?
		# allow admin
		return true if user.present? && user.admin?
	end

	private

	def developmental_edit
		record
	end
end
