class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :set_lesson, only: %i[ show edit update destroy ]

  def index
    @lessons = @course.lessons.order(position: :asc)
    authorize @lessons
  end

  def show
    authorize @lesson
    @current_position = @lesson.position
    @next_lesson = @course.lessons.find(@current_position)
  end

  def new
    @lesson = @course.lessons.build
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

    def lesson_params
      params.require(:lesson).permit(:title, :description, :slug, :content, :course_id, :position)
    end
end