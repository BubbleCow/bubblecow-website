module Services
  
  class DevelopmentalEditingPagesController < Services::ApplicationController
    skip_before_action :authenticate_user!
    before_action :set_country    
    layout 'developmental_editing_template'
    
    def developmental_editing
      @page_title = "Affordable Developmental Editing Services"
      @page_description = "Developmental editing for serious writer. Serving writers since 2007. 100+ testimonials. Discover how our combined developmental editing and line editing will give you the feedback and help you need to lift your book to a publishable standard."
      @keyword = "developmental"
      @testimonial_count = Testimonial.all.count
    end

    def book_editing
      @page_title = "Affordable Book Editing Services"
      @page_description = "Interested in book editing and looking for a book editor? Serving writers since 2007. 100+ testimonials. Discover how our book editing will give you the feedback and help you need to lift your book to a publishable standard."
      @keyword = "book"
      @testimonial_count = Testimonial.all.count
    end

    def content_editing
      @page_title = "Affordable Content Editing Services"
      @page_description = "Content editing for serious writer. Serving writers since 2007. 100+ testimonials. Discover how our combined developmental editing and line editing will give you the feedback and help you need to lift your book to a publishable standard."
      @keyword = "content"
      @testimonial_count = Testimonial.all.count
    end

    def substantive_editing
      @page_title = "Affordable Substantive Editing Services"
      @page_description = "Substantive book editing for serious writer. Serving writers since 2007. 100+ testimonials. Discover how our combined developmental editing and line editing will give you the feedback and help you need to lift your book to a publishable standard."
      @keyword = "substantive"
      @testimonial_count = Testimonial.all.count
    end

    def novel_editing
      @page_title = "Affordable Novel Editing Services"
      @page_description = "Novel editing for serious writer. Serving writers since 2007. 100+ testimonials. Discover how our combined developmental editing and line editing will give you the feedback and help you need to lift your book to a publishable standard."
      @keyword = "novel"
      @testimonial_count = Testimonial.all.count
    end

    def manuscript_editing
      @page_title = "Affordable Manuscript Editing Services"
      @page_description = "Manuscript editing for serious writer. Serving writers since 2007. 100+ testimonials. Discover how our combined developmental editing and line editing will give you the feedback and help you need to lift your book to a publishable standard."
      @keyword = "manuscript"
      @testimonial_count = Testimonial.all.count
    end

    private

    def set_country
  
      if Rails.env.development?
        @country = "GB"
      else
        @country = request.location.country
        # @country = "US" # - if country fails active this and block term above
      end
  
      case @country
  
      when "GB", "United Kingdom"
        @user_country = "United Kingdom"
        @currency_symbol = "&#163;".html_safe
        @editorial_assessment_cost = '10' #Cost of editorial assessment per 1000 words.
        @developmental_edit_cost = "15" #Cost of book editing per 1000 words.
        @developmental_edit_price = @currency_symbol + @developmental_edit_cost
        @editorial_assessment_price = @currency_symbol + @editorial_assessment_cost
      when "US", "United States"
        @user_country = "United States"
        @currency_symbol = "&#36;".html_safe
        @editorial_assessment_cost = '15' #Cost of editorial assessment per 1000 words.
        @developmental_edit_cost = "20" #Cost of book editing per 1000 words.
        @developmental_edit_price = @currency_symbol + @developmental_edit_cost
        @editorial_assessment_price = @currency_symbol + @editorial_assessment_cost
      when "Austria", "AT", "Belgium", "BE", "Cyprus", "CY", "Estonia", "EE", "Finland", "FI", "France", "FR", "Germany", "DE", "Greece", "GR", "Ireland", "IE", "Italy", "IT", "Latvia", "LV", "Lithuania", "LT", "Luxembourg", "LU", "Malta", "MT", "Netherlands", "NL", "Portugal", "PT", "Slovakia", "SK", "Slovenia", "SI", "Spain"
        @user_country = "Europe"
        @currency_symbol = "&#8364;".html_safe
        @editorial_assessment_cost = '15' #Cost of editorial assessment per 1000 words.
        @developmental_edit_cost = "20" #Cost of book editing per 1000 words.
        @developmental_edit_price = @currency_symbol + @developmental_edit_cost
        @editorial_assessment_price = @currency_symbol + @editorial_assessment_cost
      when "Australia", "AU"
        @user_country = "Australia"
        @currency_symbol = "&#36;".html_safe
        @editorial_assessment_cost = '20' #Cost of editorial assessment per 1000 words.
        @developmental_edit_cost = "30" #Cost of book editing per 1000 words.
        @developmental_edit_price = @currency_symbol + @developmental_edit_cost
        @editorial_assessment_price = @currency_symbol + @editorial_assessment_cost
      when "New Zealand", "NZ"
        @user_country = "New Zealand"
        @currency_symbol = "&#36;".html_safe
        @editorial_assessment_cost = '20' #Cost of editorial assessment per 1000 words.
        @developmental_edit_cost = "30" #Cost of book editing per 1000 words.
        @developmental_edit_price = @currency_symbol + @developmental_edit_cost
        @editorial_assessment_price = @currency_symbol + @editorial_assessment_cost
      else
        @user_country = "Other"
        @currency_symbol = "&#36;".html_safe
        @editorial_assessment_cost = '15' #Cost of editorial assessment per 1000 words.
        @developmental_edit_cost = "20" #Cost of book editing per 1000 words.
        @developmental_edit_price = @currency_symbol + @developmental_edit_cost
        @editorial_assessment_price = @currency_symbol + @editorial_assessment_cost
      end
    end

  end
end