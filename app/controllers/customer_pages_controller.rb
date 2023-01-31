class CustomerPagesController < ApplicationController
  before_action :authenticate_user!, only: [:blog_dashboard]
  before_action :set_service_price, only: [:mentoring, :manuscript_assessment, :developmental_editing, :author_platform_audit, :book_proposal] 
  before_action :set_testimonial_count, only: [:mentoring, :manuscript_assessment, :developmental_editing] 
  layout :set_template
  

  def index
    @page_title = "Affordable Book Editing Services for serious writers"
    @page_description = "Professional book editing services for serious writers. We have been providing developmental book editing and book mentors since 2007. 100+ testimonials."
    @testimonial_count = Testimonial.all.count
    @messages = Message.all
    @data_type = "organization"
  end

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

  def developmental_editing
    @page_title = "Affordable Developmental Editing Services"
    @page_description = "Developmental editing for serious writer. Serving writers since 2007. 100+ testimonials. Discover how our combined developmental editing and line editing will give you the feedback and help you need to lift your book to a publishable standard."
    @keyword = "developmental editing"
  end

  def mentoring
    @page_title = "Mentoring"
    @page_description = "One-to-one professional mentoring for writers." 
    @message = Message.new
  end

  def manuscript_assessment
    @page_title = "Affordable Manuscript Assessmet"
    @page_description = "Give your manuscript the best chance of succeeding with detailed editorial feedback from a professional book editor." 
    @message = Message.new
  end

  def book_editing_portal
    @page_title = "Book Editing Portal"
    @page_description = "Answer any questions you might have about book editing, including developmental editing, copy editing, proofreading and editorial assessments." 
  end

  def terms_and_conditions
    @page_title = "Terms and Conditions"
    @page_description = "BubbleCow's terms of service." 
  end

  def privacy_policy
    @page_title = "Privacy Policy"
    @page_description = "BubbleCow's privact policy." 
  end

  def may_2022_giveaway
    @page_title = "May 2022 Manuscript Assessment Giveaway"
    @page_description = "A one-off discounted offer for manuscript assessment." 
    @message = Message.new
  end

  def book_proposal
    @page_title = "Book Proposal Service"
    @page_description = "Prepare your book for pitching to agents and publishers." 
    @message = Message.new
  end
  

  private

  def set_template
    case action_name
    when 'index', 'book_editing_portal'
      'unformatted_page'
    when 'manuscript_assessment', 'mentoring', 'developmental_editing', 'may_2022_giveaway', 'author_platform_audit', 'book_proposal'
      'full_width'
    else
      'application'
    end
  end


  private

  def set_testimonial_count
    @testimonial_count = Testimonial.all.count
  end 

  def set_service_price

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
     
      #Cost of developmental editing per 1000 words.
      @developmental_edit_cost = "20" 
      @developmental_edit_price = @currency_symbol + @developmental_edit_cost

      # Cost of mentoring
      @mentoring_cost = "400"
      @mentoring_price = @currency_symbol + @mentoring_cost

      # Cost of manuscript assessment
      @manuscript_assessment_cost_upto_20k = "350"
      @manuscript_assessment_cost_upto_40k = "480"
      @manuscript_assessment_cost_upto_60k = "540"
      @manuscript_assessment_cost_over_60k = "8"

      # Cost of Author Platform Audit
      @author_platform_audit_cost = "100" 
      @author_platform_audit_price =  @currency_symbol + @author_platform_audit_cost

      # Cost of book proposal
      @book_proposal_cost = "400"
      @book_proposal_price =  @currency_symbol + @book_proposal_cost

    when "US", "United States"

      @user_country = "United States"
      @currency_symbol = "&#36;".html_safe

      #Cost of developmental editing per 1000 words.
      @developmental_edit_cost = "25"
      @developmental_edit_price = @currency_symbol + @developmental_edit_cost

      # Cost of mentoring
      @mentoring_cost = "500"
      @mentoring_price = @currency_symbol + @mentoring_cost

       # Cost of manuscript assessment
      @manuscript_assessment_cost_upto_20k = "450"
      @manuscript_assessment_cost_upto_40k = "600"
      @manuscript_assessment_cost_upto_60k = "680"
      @manuscript_assessment_cost_over_60k = "10"

      # Cost of Author Platform Audit
      @author_platform_audit_cost = "150" 
      @author_platform_audit_price =  @currency_symbol + @author_platform_audit_cost

      # Cost of book proposal
      @book_proposal_cost = "500"
      @book_proposal_price =  @currency_symbol + @book_proposal_cost
     
    when "Austria", "AT", "Belgium", "BE", "Cyprus", "CY", "Estonia", "EE", "Finland", "FI", "France", "FR", "Germany", "DE", "Greece", "GR", "Ireland", "IE", "Italy", "IT", "Latvia", "LV", "Lithuania", "LT", "Luxembourg", "LU", "Malta", "MT", "Netherlands", "NL", "Portugal", "PT", "Slovakia", "SK", "Slovenia", "SI", "Spain"
      
      @user_country = "Europe"
      @currency_symbol = "&#8364;".html_safe
      
      #Cost of developmental editing per 1000 words.
      @developmental_edit_cost = "25"
      @developmental_edit_price = @currency_symbol + @developmental_edit_cost

      # Cost of mentoring
      @mentoring_cost = "500"
      @mentoring_price = @currency_symbol + @mentoring_cost

      # Cost of manuscript assessment
      @manuscript_assessment_cost_upto_20k = "420"
      @manuscript_assessment_cost_upto_40k = "570"
      @manuscript_assessment_cost_upto_60k = "640"
      @manuscript_assessment_cost_over_60k = "10"

      # Cost of Author Platform Audit
      @author_platform_audit_cost = "125" 
      @author_platform_audit_price =  @currency_symbol + @author_platform_audit_cost

      # Cost of book proposal
      @book_proposal_cost = "500"
      @book_proposal_price =  @currency_symbol + @book_proposal_cost

    when "Australia", "AU"

      @user_country = "Australia"
      @currency_symbol = "&#36;".html_safe

      #Cost of developmental editing per 1000 words.
      @developmental_edit_cost = "35" 
      @developmental_edit_price = @currency_symbol + @developmental_edit_cost
      
      # Cost of mentoring
      @mentoring_cost = "580"
      @mentoring_price = @currency_symbol + @mentoring_cost

      # Cost of manuscript assessment
      @manuscript_assessment_cost_upto_20k = "620"
      @manuscript_assessment_cost_upto_40k = "850"
      @manuscript_assessment_cost_upto_60k = "960"
      @manuscript_assessment_cost_over_60k = "15"

      # Cost of Author Platform Audit
      @author_platform_audit_cost = "200" 
      @author_platform_audit_price =  @currency_symbol + @author_platform_audit_cost

      # Cost of book proposal
      @book_proposal_cost = "700"
      @book_proposal_price =  @currency_symbol + @book_proposal_cost

    when "New Zealand", "NZ"
      @user_country = "New Zealand"
      @currency_symbol = "&#36;".html_safe
     
      #Cost of developmental editing per 1000 words.
      @developmental_edit_cost = "35"
      @developmental_edit_price = @currency_symbol + @developmental_edit_cost

      # Cost of mentoring
      @mentoring_cost = "635"
      @mentoring_price = @currency_symbol + @mentoring_cost

      # Cost of manuscript assessment
      @manuscript_assessment_cost_upto_20k = "685"
      @manuscript_assessment_cost_upto_40k = "940"
      @manuscript_assessment_cost_upto_60k = "1055"
      @manuscript_assessment_cost_over_60k = "15"

      # Cost of Author Platform Audit
      @author_platform_audit_cost = "200" 
      @author_platform_audit_price =  @currency_symbol + @author_platform_audit_cost

      # Cost of book proposal
      @book_proposal_cost = "800"
      @book_proposal_price =  @currency_symbol + @book_proposal_cost

    else
      @user_country = "Other"
      @currency_symbol = "&#36;".html_safe

      #Cost of developmental editing per 1000 words.
      @developmental_edit_cost = "25"
      @developmental_edit_price = @currency_symbol + @developmental_edit_cost

      # Cost of mentoring
      @mentoring_cost = "500"
      @mentoring_price = @currency_symbol + @mentoring_cost

       # Cost of manuscript assessment
      @manuscript_assessment_cost_upto_20k = "450"
      @manuscript_assessment_cost_upto_40k = "600"
      @manuscript_assessment_cost_upto_60k = "680"
      @manuscript_assessment_cost_over_60k = "10"

      # Cost of Author Platform Audit
      @author_platform_audit_cost = "150" 
      @author_platform_audit_price =  @currency_symbol + @author_platform_audit_cost

      # Cost of book proposal
      @book_proposal_cost = "500"
      @book_proposal_price =  @currency_symbol + @book_proposal_cost
      
    end

  end

end

