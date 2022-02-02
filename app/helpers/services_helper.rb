module ServicesHelper

    # Checks if the user has either sample or edit from the pre-2022 update
	def user_has_old_edits_or_samples
		current_user.sample_developmental_edits.present? || current_user.developmental_edits.present?
	end

	# Checks to see if the user has more than one book
	def user_has_more_than_one_book
		current_user.books.count > 1
	end

	# Checks to see if the user has one or more books
	def user_has_one_or_more_books
		current_user.books.count >= 1
	end

	# Checks if the user has either sample or edit from the pre-2022 update AND one or more books
	def user_has_old_edits_and_more_than_one_book
		current_user.sample_developmental_edits.present? || current_user.developmental_edits.present? && current_user.books.count >= 1
	end

	# Checks if the user has either sample or edit from the pre-2022 update AND more than one book
	def user_has_old_edits_and_more_than_one_book
		current_user.sample_developmental_edits.present? || current_user.developmental_edits.present? && current_user.books.count > 1
	end

	# Checks if user has sample develomental edits submitted prior to 2022 upgrade
	def user_has_sample_developmental_edits
		current_user.sample_developmental_edits.present? 
	end

	# Checks if user has develomental edits submitted prior to 2022 upgrade
	def user_has_developmental_edits
		current_user.developmental_edits.present? 
	end
	
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

	    # Outputs a message based on the status of the developmental edit
		def status_message(status)

			case status
	
				when "developmental_edit_created"
					content_tag(:p, "We are currently assessing your manuscript.")
				when "developmental_edit_rejected"
					content_tag(:p, "Unfortunately, we will not be able to provide an edit.")
				when "developmental_edit_accepted"
					content_tag(:p, "Your manuscript has been assessed, and I am glad to say that we can add value and will provide an edit.")
				when "developmental_edit_invoice_sent"
					content_tag(:p, "We are currently waiting for payment before we can begin your edit.")
				when "developmental_edit_invoice_paid"
					content_tag(:p, "Your book is currently being edited.")
				when "developmental_edit_editing_underway" 
					content_tag(:p, "Your book is currently being edited.")
				when "developmental_edit_returned"
					content_tag(:p, "Your feedback is now ready.")
				when "sample_developmental_edit_submitted"
					content_tag(:p, "We are currently assessing your manuscript and will get back to you shortly.")
				when "sample_developmental_edit_rejected"
					content_tag(:p, "Unfortunately, we will not be able to provide a sample edit.")
				when "sample_developmental_edit_accepted"
					content_tag(:p, "Your sample has been accepted and is currently being edited.")
				when "sample_developmental_edit_editing_underway"
					content_tag(:p, "Your sample has been accepted and is currently being edited.")
				when "sample_developmental_edit_returned"
					content_tag(:p, "Your sample feedback is now ready.")
				end
			
		end

end
