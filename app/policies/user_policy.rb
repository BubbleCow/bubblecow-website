class UserPolicy < ApplicationPolicy

	def show?
		return true if user.present? && user.admin?
	end

	private

	def post
		record
	end

end