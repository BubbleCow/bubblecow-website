class CustomerPagesController < ApplicationController
  before_action :authenticate_user!, only: [:blog_dashboard]
  before_action :set_testimonial_count, only: [:mentoring, :manuscript_assessment, :developmental_editing] 
  before_action :set_country, only: [:developmental_editing, :copy_editing, :manuscript_assessment, :index]
  layout :set_template
  

  def index
    @page_title = "Affordable Book Editing Services for serious writers"
    @page_description = "Professional book editing services for serious writers. We have been providing developmental book editing and book mentors since 2007. 100+ testimonials."
    @testimonial_count = Testimonial.all.count
    @messages = Message.all
    @data_type = "organization"
    @price_for_developmental_editing = ProductPricing.new(@country, 'Developmental Editing').display_product_cost
    @price_for_copy_editing = ProductPricing.new(@country, 'Copy Editing').display_product_cost
    @price_for_manuscript_assessment = ProductPricing.new(@country, 'Manuscript Assessment').display_product_cost
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
    @product_pricing = ProductPricing.new(@country, 'Developmental Editing')
    @price = @product_pricing.display_product_cost
  end

  def copy_editing
    @page_title = "Copy Editing Services For Authors"
    @page_description = "Bringing Clarity and Precision to Your Words" 
    @keyword = "copy editing"
    @message = Message.new
    @product_pricing = ProductPricing.new(@country, 'Copy Editing')
    @price = @product_pricing.display_product_cost
  end

  def manuscript_assessment
    @page_title = "Affordable Manuscript Assessment"
    @page_description = "Give your manuscript the best chance of succeeding with detailed editorial feedback from a professional book editor." 
    @message = Message.new
    @product_pricing = ProductPricing.new(@country, 'Manuscript Assessment')
    @price = @product_pricing.display_product_cost
  end
  
  def mentoring
    @page_title = "Book Mentoring"
    @page_description = "One-to-one professional mentoring for writers." 
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
    @page_title = "Book Proposal Services"
    @page_description = "Prepare your book for pitching to agents and publishers." 
    @message = Message.new
  end
  
  private

  def set_template
    case action_name
    when 'index', 'manuscript_assessment', 'mentoring', 'developmental_editing', 'may_2022_giveaway', 'author_platform_audit', 'book_proposal', 'copy_editing'
      'full_width'
    else
      'application'
    end
  end

  def set_testimonial_count
    @testimonial_count = Testimonial.all.count
  end 

  # Sets the country
  def set_country
    if Rails.env.development?
      @country = "GB"
    else
      @country = request.location.country
    end
  end

end

