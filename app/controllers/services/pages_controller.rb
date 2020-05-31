module Services
  class PagesController < Services::ApplicationController
    layout :resolve_layout
    
    def index
    end

   
    private
      def resolve_layout
        case action_name
        when "index"
          "application"
        else
          "application"
        end
      end

  end
end
