class AdminArea::AdminPagesPolicy < ApplicationPolicy
    
    def dashboard?
		# allow admin
		return true if user.present? && user.admin?
	end

	def blog?
		# allow admin
		return true if user.present? && user.admin?
	end

	def testimonials?
		# allow admin
		return true if user.present? && user.admin?
	end

	def services?
		# allow admin
		return true if user.present? && user.admin?
	end

	def users?
		# allow admin
		return true if user.present? && user.admin?
	end

	def genres?
		# allow admin
		return true if user.present? && user.admin?
	end

end
