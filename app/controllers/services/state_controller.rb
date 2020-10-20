module Services
  
    class StateController < Services::ApplicationController
        before_action :set_developmental_edit, only: [:developmental_edit_accepted, :developmental_edit_rejected]

        # state controls

        def developmental_edit_accepted
            redirect_to services_developmental_edit_path(@developmental_edit), notice: "#{@developmental_edit.title.titleize} was successfully accepted."
        end
  
        def developmental_edit_rejected
            # Update aasm state
            @developmental_edit.edit_rejected!

            # Update active campaign tag
            # ActiveCampaignService.new.contact_tag_add(@developmental_edit.user.email, "Developmental Edit Rejected")

            # Send email
            DevelopmentalEditMailer.developmental_edit_rejected(@developmental_edit.user, @developmental_edit).deliver

            # Redirect 
            redirect_to services_developmental_edit_path(@developmental_edit), notice: "#{@developmental_edit.title.titleize} was successfully rejected."
        end

        private
        def set_developmental_edit
          @developmental_edit = DevelopmentalEdit.friendly.find(params[:id])
        end  

    end

end