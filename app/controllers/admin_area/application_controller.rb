module AdminArea 
    class ApplicationController < ApplicationController
        before_action :authenticate_user!
        before_action :set_side_nav_bar

        def set_side_nav_bar
            @unread_messages = Message.unread
            @unprocessed_developmental_edits = DevelopmentalEdit.developmental_edit_submitted
            @unprocessed_sample_developmental_edits = SampleDevelopmentalEdit.sample_developmental_edit_submitted
        end
    
    end
end