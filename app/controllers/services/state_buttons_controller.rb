module Services
  
    class StateButtonsController < Services::ApplicationController
        before_action :set_developmental_edit, only: [:developmental_edit_accepted, :developmental_edit_rejected]
        before_action :set_sample_developmental_edit, only: [:sample_developmental_edit_rejected, :sample_developmental_edit_accepted]

        # state controls

        def developmental_edit_rejected
            # Update aasm state
            @developmental_edit.developmental_edit_rejected!

            # Redirect 
            redirect_to services_developmental_edit_path(@developmental_edit), notice: "#{@developmental_edit.title.titleize} was successfully rejected."
        end
        
        def developmental_edit_accepted
            # Update aasm state
            @developmental_edit.developmental_edit_accepted!

            redirect_to services_developmental_edit_path(@developmental_edit), notice: "#{@developmental_edit.title.titleize} was successfully accepted."
        end

        def sample_developmental_edit_rejected
            # Update aasm state
            @sample_developmental_edit.sample_developmental_edit_rejected!

            # Redirect 
            redirect_to services_sample_developmental_edit_path(@sample_developmental_edit), notice: "#{@sample_developmental_edit.title.titleize} was successfully rejected."
        end
        
        def sample_developmental_edit_accepted
            # Update aasm state
            @sample_developmental_edit.sample_developmental_edit_accepted!

            redirect_to services_sample_developmental_edit_path(@sample_developmental_edit), notice: "#{@sample_developmental_edit.title.titleize} was successfully accepted."
        end
  

        private
        def set_developmental_edit
            @developmental_edit = DevelopmentalEdit.friendly.find(params[:id])
        end  

        def set_sample_developmental_edit
            @sample_developmental_edit = SampleDevelopmentalEdit.friendly.find(params[:id])
        end  

    end

end