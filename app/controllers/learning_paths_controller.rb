class LearningPathsController < ApplicationController
  # Use before_action filters to load necessary data for specific actions
  before_action :load_learning_path, except: [:index, :create]
  before_action :load_courses, only: [:assign_courses_to_learning_path, :remove_courses_from_learning_path]
  
  # GET /learning_paths
  # Retrieve all learning paths
  def index
    learning_paths = LearningPath.all
    render json: learning_paths
  end

  # GET /learning_paths/:id
  # Retrieve a specific learning path by ID
  def show
    render json: @learning_path
  end

  # POST /learning_paths
  # Create a new learning path
  def create
    learning_path = LearningPath.new(learning_path_params)

    if learning_path.save
      render json: learning_path, status: :created
    else
      render json: learning_path.errors, status: :unprocessable_entity
    end
  end

  # PUT /learning_paths/:id
  # Update an existing learning path by ID
  def update
    if @learning_path.update(learning_path_params)
      render json: @learning_path
    else
      render json: @learning_path.errors, status: :unprocessable_entity
    end
  end

  # DELETE /learning_paths/:id
  # Delete a learning path by ID
  def destroy
    @learning_path.destroy
    render json: { message: 'Learning path deleted successfully' }, status: :ok
  end

  # Custom action to remove courses from a learning path
  def remove_courses_from_learning_path
    @courses.each do |course|
      if @learning_path.courses.include?(course)
        destroy_referenced_records_for_courses(course)
      else
        @course_errors.add(:base, "Course with id:#{course.id} not included in LearningPath")
      end
    end
    render json: { message: [ 'Courses deleted successfully', @course_errors.messages[:base] ] }, status: :ok
  end

  # Custom action to assign courses to a learning path
  def assign_courses_to_learning_path
    @courses.each do |course|
      unless @learning_path.courses.include?(course)
        @learning_path.courses << course
      end
    end
    render json: { message: ['Course assigned to the learning path successfully', @course_errors.messages[:base].first] }, status: :ok
  end

  private

  # Strong parameters for learning path creation and update
  def learning_path_params
    params.require(:learning_path).permit(:title,:start_date, :end_date)
  end

  # Load the learning path based on the provided ID
  def load_learning_path
    @learning_path = LearningPath.find_by(id: params[:id])
    render json: { alert: 'Learning path not found' }, status: :not_found unless @learning_path.present?
  end

  # Load courses based on the provided parameters
  def load_courses
    @course_errors = ActiveModel::Errors.new(self)
    @courses = Course.where(id: params[:courses])
    return render json: { message: 'Courses not found' }, status: :ok unless @courses.any?

    available_courses = Course.where(id: params[:courses]).pluck(:id)
    @course_errors.add(:base, "Course ids #{params[:courses] - available_courses} not found")
  end

  def destroy_referenced_records_for_courses(course)
    course_learning_path = CoursesLearningPath.find_by(course_id: course.id, learning_path_id: @learning_path.id)
    course_learning_path.course_learning_path_details.destroy_all
    course_learning_path.destroy
  end
end
