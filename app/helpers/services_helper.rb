module ServicesHelper

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

	# predicts cost of developmental edit
	def developmental_edit_cost_quote(sample_edit)
		case sample_edit.user.country 
		when "uk"
			"£#{(sample_edit.word_count/1000)*15}" 
		when "us"
			"$#{(sample_edit.word_count/1000)*20}"
		else
			"$#{(sample_edit.word_count/1000)*20}" 
		end
	end

	# currency options
	def currency_options
		[['American Dollar $', 'usd'], ['British Pound £', 'gbp'], ['Euro E', 'euro'], ['Australian Dollar $', 'aud']]
	end

	# currency options
	def country_options
		[['United States', 'us'], ['Great Britian', 'gb']]
	end

end
