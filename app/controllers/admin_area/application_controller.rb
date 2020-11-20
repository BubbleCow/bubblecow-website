module AdminArea 
    class ApplicationController < ApplicationController
        before_action :authenticate_user!
        before_action :set_side_nav_bar

        def set_side_nav_bar
            @unread_messages = Message.unread
        end
    
    end
end