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
    # Extract instructor data from the request parameters
    instructor = params[:course][:instructor_attributes]

    # Check if the instructor type is a talent
    if instructor[:type].downcase == 'talent'
      # Find a Talent by the provided ID
      instructor = Talent.find_by(id: instructor[:id].to_i)
    else 
      # Find an Author by the provided ID
      instructor = Author.find_by(id: instructor[:id].to_i)
    end

    # Create a new Course instance with the given parameters
    course = Course.new(course_params)

    # Associate the found instructor with the course, if present
    if instructor.present?
      course.instructor = instructor
    end

    # Attempt to save the course
    if course.save
      render json: course, status: :created
    else
      # If course creation fails, render the course errors as JSON with a 422 status
      render json: course.errors, status: :unprocessable_entity
    end
  end

  # PUT /courses/:id
  # Update an existing course by ID
  def update
    # Extract instructor data from the request parameters
    instructor_data = params[:course][:instructor_attributes]

    # Check if instructor data is present in the request
    if instructor_data.present?
      # Check the type of instructor (Talent or Author)
      if instructor_data[:type].downcase == 'talent'
        # If the instructor type is Talent, find the Talent by ID
        instructor = Talent.find_by(id: instructor_data[:id].to_i)
      else
        # If the instructor type is Author, find the Author by ID
        instructor = Author.find_by(id: instructor_data[:id].to_i)
      end

      # Associate the found instructor with the course
      @course.instructor = instructor
    end

    # Attempt to update the course with the provided parameters
    if @course.update(course_params)
      render json: @course
    else
      # If the update fails, render the course errors as JSON with a 422 status
      render json: @course.errors, status: :unprocessable_entity
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
    if @course_talents.first.pending?
      render json: { message: 'Cannot complete this course as it is still in the pending stage' }, status: :ok
    else 
      @course_talents.first.mark_as_completed!
      render json: { message: 'Course completed' }, status: :ok
    end
  end

  private

  # Strong parameters for course creation and update
  def course_params
    params.require(:course).permit(:title, :description, :instructor_attributes, :course_code)
  end

  def load_course
    @course = Course.find_by(id: params[:id])
    render json: { error: 'Course not found' }, status: :not_found unless @course.present?
  end

  # Load course talents based on the provided parameters
  def load_courses_talent
    @course_talents = CoursesTalent.where(course_id: params[:id], talent_id: params[:talent_id])
    render json: { alert: 'Course not found' }, status: :not_found unless @course_talents.any?
  end

  # Load course talents based on the provided parameters within a learning path
  def load_learning_path_course_talent
    course_learning_paths = CoursesLearningPath.where(learning_path_id: params[:learning_path_id], course_id: params[:id])
    render json: { alert: 'Course not found' }, status: :not_found unless course_learning_paths.any?

    @course_talents = CourseLearningPathDetail.where(courses_learning_path_id: course_learning_paths.first.id, talent_id: params[:talent_id])
    render json: { alert: 'Course not found' }, status: :not_found unless @course_talents.any?
  end
end
