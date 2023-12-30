class LessonsController < ApplicationController
  # before_action :authenticate_user!
  before_action :store_user_location!, only: [:show] 
  before_action :redirect_unauthenticated_users, only: [:show]
  before_action :set_course
  before_action :set_lesson, only: %i[ show edit update destroy ]
  before_action :set_ac_tag, only: %i[ show ]
  layout :set_layout
  
  def index
    @page_title = "Lessons for #{@course.title}"
    @lessons = policy_scope(@course.lessons)
    authorize @lessons
  end

  def show
    @page_title = @lesson.title.titleize
    authorize @lesson
  end

  def new
    max_position = @course.lessons.maximum(:position) || 0
    @lesson = @course.lessons.build(position: max_position + 1)
    authorize @lesson
  end


  def edit
    authorize @lesson
  end

  def create
    @lesson = @course.lessons.build(lesson_params)
    authorize @lesson
    respond_to do |format|
      if @lesson.save
        format.html { redirect_to course_lessons_path(@course), notice: "Lesson was successfully created." }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @lesson
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to course_lesson_path(@course, @lesson), notice: "Lesson was successfully updated." }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @lesson
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to course_lessons_path, notice: "Lesson was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_course
      @course = Course.friendly.find(params[:course_id])
    end

    def set_lesson
      @lesson = @course.lessons.friendly.find(params[:id])
    end

    def set_ac_tag
      
      case @course.ac_tag

      when 'book proposal'

        # Send tag to Active Campaign
        # ActiveCampaignService.new.contact_tag_add(current_user.email, "Service - Book Proposal - Interest")
      
      end

    end

    # Redirects users not logged in 
    def redirect_unauthenticated_users
      return if user_signed_in?
      @course = Course.friendly.find(params[:course_id])
      if @course.access_level == 'free'
        redirect_to free_signup_path
      else
        redirect_to paid_signup_path
      end
    end

    def lesson_params
      params.require(:lesson).permit(:title, :description, :slug, :content, :course_id, :position)
    end

    def set_layout
      case action_name
      when 'new', 'edit', 'show'
          'page_templates/page_small'
      when 
          'page_templates/page_medium'
      when 
          'page_templates/page_large'
      else
        'application'
      end
    end

end
