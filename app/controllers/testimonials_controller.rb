class TestimonialsController < ApplicationController
before_action :set_testimonial, only: [:show, :edit, :update, :destroy]

  def index
    @testimonials = Testimonial.all
    authorize @testimonials
    @page_title = "BubbleCow Testimonials"
    @page_description = "Find out what people are saying about BubbleCow."
  end

  def show
    authorize @testimonial
  end

  def new
    @testimonial = Testimonial.new
    authorize @testimonial
  end

  def edit
    authorize @testimonial
  end

  def create
    @testimonial = Testimonial.new(testimonial_params)
    authorize @testimonial
    respond_to do |format|
      if @testimonial.save
        format.html { redirect_to testimonials_path, notice: 'Testimonial was successfully created.' }
        format.json { render :show, status: :created, location: @testimonial }
      else
        format.html { render :new }
        format.json { render json: @testimonial.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @testimonial
    respond_to do |format|
      if @testimonial.update(testimonial_params)
        format.html { redirect_to testimonials_path, notice: 'Testimonial was successfully updated.' }
        format.json { render :show, status: :ok, location: @testimonial }
      else
        format.html { render :edit }
        format.json { render json: @testimonial.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @testimonial
    @testimonial.destroy
    respond_to do |format|
      format.html { redirect_to admin_dashboard_path, notice: 'Testimonial was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_testimonial
      @testimonial = Testimonial.friendly.find(params[:id])
    end

    def testimonial_params
      params.require(:testimonial).permit(:writer, :approved, :testimonial_text)
    end

end    


