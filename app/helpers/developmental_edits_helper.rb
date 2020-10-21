module DevelopmentalEditsHelper

    # Proposed due date for edits - 28 working days from today
	def proposed_developmental_edit_due_date
	    time = Date.today + 37.days
	    time.strftime("%B %d")
	end

end
