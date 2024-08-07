class ServicePagesController < ApplicationController
  before_action :set_testimonial_count, only: [:mentoring, :manuscript_assessment, :developmental_editing] 
  before_action :set_country, only: [:developmental_editing, :copy_editing, :manuscript_assessment, :index]
  layout :set_layout

  def index
    @page_title = "Book Editing Services for serious writers"
    @page_description = "Professional book editing services for serious writers. We have been providing developmental book editing and book mentors since 2007. 100+ testimonials."
    @testimonial_count = Testimonial.all.count
    @messages = Message.all
    @data_type = "organization"
    @price_for_developmental_editing = ProductPricing.new(@country, 'Developmental Editing').display_product_cost
    @price_for_copy_editing = ProductPricing.new(@country, 'Copy Editing').display_product_cost
    @price_for_manuscript_assessment = ProductPricing.new(@country, 'Manuscript Assessment').display_product_cost
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

  private

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

  def set_layout
    case action_name
    when
        'page_templates/page_small'
    when 
        'page_templates/page_medium'
    when 'index','book_editing_portal'
        'page_templates/page_large'
    else
      'application'
    end
  end

end

