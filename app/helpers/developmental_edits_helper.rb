module DevelopmentalEditsHelper

    # Proposed due date for edits - 28 working days from today
	def proposed_developmental_edit_due_date
	    time = Date.today + 37.days
	    time.strftime("%B %d")
	end	   
	   
	# Changes colour of overdue edits to red
	def table_class(developmental_edit_due_date)
		if developmental_edit_due_date > Date.today
			"<tr class='ontime'>".html_safe
		else
			"<tr class='table-danger'>".html_safe
		end 
	end
end
