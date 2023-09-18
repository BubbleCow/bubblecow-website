class StaticPagesController < ApplicationController
    
    def about
        @page_title = "About BubbleCow"
        @page_description = "BubbleCow started editing books and helping writers to success in 2007. Discover the BubbleCow story and meet our founder."
        @data_type = "local_business"
    end
    
    def thanks
        @page_title = "Thanks for your payment"
        @page_description = "Thanks for payment. We will be in touch shortly."
        @footer = "no footer"
    end
    
    def writing_manual
        @page_title = "The Writing Manual"
        @page_description = "Download your free copy of the 'famous' Writing Manual." 
    end 
    
    def file_safety
        @page_title = "File Safety"
        @page_description = "Discover how we ensure your manuscript is kept safe." 
    end

    def terms_and_conditions
        @page_title = "Terms and Conditions"
        @page_description = "BubbleCow's terms of service." 
    end
    
    def privacy_policy
        @page_title = "Privacy Policy"
        @page_description = "BubbleCow's privact policy." 
    end


end