class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]
  layout :set_layout

  def index
    @courses = Course.all
    authorize @courses
  end

  def show
    authorize @course
    @page_title = @course.title 
    @lessons = @course.lessons.order(position: :asc)
  end

  def new
    @course = Course.new
    authorize @course
  end

  def edit
    authorize @course
  end

  def create
    @course = Course.new(course_params)
    authorize @course
    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @course
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @course
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_course
      @course = Course.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :description, :slug, :description_short, :access_level, :ac_tag)
    end
  
    def set_layout
      case action_name
      when 'show'
          'page_templates/page_small'
      when 'new', 'index', 'edit'
          'page_templates/page_medium'
      when 
          'page_templates/page_large'
      else
        'application'
      end
    end

end
