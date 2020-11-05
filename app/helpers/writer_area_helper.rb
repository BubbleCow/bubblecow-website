module WriterAreaHelper

    # Set shadow on deve edit card 
	def is_being_edited?(status)       
		return 'shadow' if status != "developmental_edit_rejected"     
	end
end