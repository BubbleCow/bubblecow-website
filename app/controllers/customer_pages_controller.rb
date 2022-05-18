class CustomerPagesController < ApplicationController
  before_action :authenticate_user!, only: [:blog_dashboard]
  before_action :set_service_price, only: [:mentoring, :manuscript_assessment] 
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

  def mentoring
    @page_title = "Mentoring"
    @page_description = "One-to-one professional mentoring for writers." 
    @message = Message.new
  end

  def manuscript_assessment
    @page_title = "Affordable Manuscript Assessmet"
    @page_description = "Give your manuscript the best chance of succeeding with detailed editorial feedback from a professional book editor." 
    @message = Message.new
    @testimonial_count = Testimonial.all.count
  end

  def book_editing_portal
    @page_title = "Book Editing Portal"
    @page_description = "Answer any questions you might have about book editing, including developmental editing, copy editing, proofreading and editorial assessments." 
  end
  

  private

  def set_template
    case action_name
    when 'index', 'mentoring', 'writing_manual', 'book_editing_portal'
      'unformatted_page'
    when 'manuscript_assessment'
      'full_width'
    else
      'application'
    end
  end


  private

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

      @mentoring_cost = "325"
      @mentoring_price = @currency_symbol + @mentoring_cost

      @manuscript_assessment_cost_upto_20k = "350"
      @manuscript_assessment_cost_upto_40k = "480"
      @manuscript_assessment_cost_upto_60k = "540"
      @manuscript_assessment_cost_over_60k = "8"

    else 
      @user_country = "United States"
      @currency_symbol = "&#36;".html_safe

      @mentoring_cost = "500"
      @mentoring_price = @currency_symbol + @mentoring_cost
      
      @manuscript_assessment_cost_upto_20k = "450"
      @manuscript_assessment_cost_upto_40k = "600"
      @manuscript_assessment_cost_upto_60k = "670"
      @manuscript_assessment_cost_over_60k = "10"

    end
  end

end
