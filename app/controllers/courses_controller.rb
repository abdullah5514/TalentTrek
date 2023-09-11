class CoursesController < ApplicationController
  # Use before_action filters to load necessary data for specific actions
  before_action :load_courses_talent, only: :complete_course, if: -> { !params[:learning_path_id].present? && params[:talent_id].present? }
  before_action :load_learning_path_course_talent, only: :complete_course, if: -> { params[:learning_path_id].present? && params[:talent_id].present? }
  before_action :load_course, only: [:show, :update, :destroy]

  # GET /courses
  # Retrieve all courses
  def index
    courses = Course.all
    render json: courses
  end

  # GET /courses/:id
  # Retrieve a specific course by ID
  def show
    render json: @course
  end

  # POST /courses
  # Create a new course
  def create
    course = Course.new(course_params)
      if course.save
        render json: course, status: :created
      else
        render json: course.errors, status: :unprocessable_entity
      end
  end

  # PUT /courses/:id
  # Update an existing course by ID
  def update
    # Find the course by its ID
    course = Course.find_by(id: params[:id])
    # Attempt to update the course with the provided parameters
    if course.update(course_params)
      render json: course
    else
      # If the update fails, render the course errors as JSON with a 422 status
      render json: course.errors, status: :unprocessable_entity
    end
  end

  # DELETE /courses/:id
  # Delete a course by ID
  def destroy
    @course.destroy
    render(json: { message: 'Course deleted successfully' }, status: :ok)
  end

  # Custom action to complete a course
  def complete_course
    if params[:learning_path_id].present? && @course_talent.pending?
      render json: { message: 'Cannot complete this course as it is still in the pending stage' }, status: :ok
    elsif @course_talent.mark_as_completed!
      render json: { message: 'Course completed' }, status: :ok
    else
      render json: course.errors, status: :unprocessable_entity
    end
  rescue Exception => e
    render json: e, status: :unprocessable_entity
  end

  private

  # Strong parameters for course creation and update
  def course_params
     params.require(:course).permit(:title,:description, :course_code, :instructor_type, :instructor_id)
  end

  def load_course
    @course = Course.find_by(id: params[:id])
    render json: { error: 'Course not found' }, status: :not_found unless @course.present?
  end

  # Load course talents based on the provided parameters
  def load_courses_talent
    @course_talent = CoursesTalent.where(course_id: params[:id], talent_id: params[:talent_id]).first
    render json: { alert: 'Course not found' }, status: :not_found unless @course_talent.present?
  end

  # Load course talents based on the provided parameters within a learning path
  def load_learning_path_course_talent
    course_learning_path = CoursesLearningPath.where(learning_path_id: params[:learning_path_id], course_id: params[:id]).first
    return render json: { alert: 'Course LearingPath not found' }, status: :not_found unless course_learning_path.present?

    @course_talent = CourseLearningPathDetail.where(courses_learning_path_id: course_learning_path.id, talent_id: params[:talent_id]).first
    render json: { alert: 'Course LearningPath detail not found' }, status: :not_found unless @course_talent.present?
  end
end
