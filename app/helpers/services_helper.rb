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

	# currency options
	def currency_options
		[['American Dollar $', 'usd'], ['British Pound £', 'gbp'], ['Euro E', 'euro'], ['Australian Dollar $', 'aud']]
	end

	# country options
	def country_options
		[['United States', 'us'], ['Great Britian', 'gb']]
	end

	# quote for developmental editing
	def developmental_edit_quote(sample_edit)
		@symbol =
		case sample_edit.user.currency
		when "usd"
			"$"
		when "gbp"
			"£"
		when "euro"
			"e"
		when "aud"
			"$"
		when 
			"$"
		end

		@symbol + sample_edit.developmental_editing_quote.to_s

	end

end
