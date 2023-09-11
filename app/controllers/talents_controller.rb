class TalentsController < ApplicationController
  # Before action to load talent, except for create and show actions
  before_action :load_talent, except: [:create, :index]
  
  # Before action to load courses, used in assign_courses_to_talent and remove_courses_from_talent
  before_action :load_courses, only: [:assign_courses_to_talent, :remove_courses_from_talent]
  
  # Before action to load learning path, used in assign_learning_path_to_talent
  before_action :load_learning_path, only: :assign_learning_path_to_talent

  # GET /talents
  # Retrieve all talents
  def index
    talents = Talent.all
    render json: talents
  end

  # GET /talents/:id
  # Retrieve a specific talent by ID
  def show
    render json: @talent
  end

  # POST /talents
  # Create a new talent
  def create
    talent = Talent.new(talent_params)

    if talent.save
      render json: talent, status: :created
    else
      render json: talent.errors, status: :unprocessable_entity
    end
  end

  # PUT /talents/:id
  # Update an existing talent by ID
  def update
    if @talent.update(talent_params)
      render json: @talent
    else
      render json: @talent.errors, status: :unprocessable_entity
    end
  end

  # DELETE /talents/:id
  # Delete a talent by ID
  def destroy
    @talent.destroy
    render json: { message: 'Talent deleted successfully' }, status: :ok
  end
  
  # POST /talents/:id/assign_courses
  # Assign courses to a talent
  def assign_courses_to_talent
    @courses.each do |course|
      # Check if the course is not already assigned to the talent
      unless @talent.courses.include?(course)
        @talent.courses << course
      end
    end
    render json: { message: ['Course assigned to the talent successfully', @course_errors.messages[:base].first] }, status: :ok
  end

  # POST /talents/:id/remove_courses
  # Remove courses from a talent
  def remove_courses_from_talent
    @courses.each do |course|
      @talent.courses.delete(course)
    end
    render json: { message: ['Courses deleted successfully', @course_errors.messages[:base].first] }, status: :ok
  end

  # POST /talents/:id/assign_learning_path
  # Assign a learning path to a talent
  def assign_learning_path_to_talent
    # Create a new LearningPathTalent association
    @learning_path_talent = LearningPathTalent.new(learning_path: @learning_path, talent: @talent)

    if @learning_path_talent.save
      return unless @learning_path.courses.present?
      
      # Create course learning path details for the talent
      create_course_learning_path_details
      render json: { message: ["Learning path assigned to talent successfully.", @course_errors.messages[:base].first] }, status: :ok
    else
      render json: { error: "Failed to assign learning path to talent." }, status: :unprocessable_entity
    end
  end

  private

  # Strong parameters for talent creation and update
  def talent_params
    params.require(:talent).permit(:name, :roll_no, :email)
  end

  # Load talent by ID
  def load_talent
    @talent = Talent.find_by(id: params[:id])
    render json: { error: 'Talent not found' }, status: :not_found unless @talent.present?
  end

  # Load courses by IDs
  def load_courses
    @course_errors = ActiveModel::Errors.new(self)
    @courses = Course.where(id: params[:courses])
    available_courses = Course.where(id: params[:courses]).pluck(:id)
    @course_errors.add(:base, "Course ids #{params[:courses] - available_courses} not found")
  end

  # Load learning path by ID
  def load_learning_path
    @learning_path = LearningPath.find_by(id: params[:learning_path_id])
    render json: { error: 'Learning Path not found' }, status: :not_found unless @learning_path.present?
  end

  # Create course learning path details for the talent
  def create_course_learning_path_details
    courses_learning_paths = @learning_path.courses_learning_paths.order(:id)
    courses_learning_paths.each_with_index do |clp, index|
      create_course_learning_path_detail(clp, index)
    end
  end

  def create_course_learning_path_detail(clp, index)
    CourseLearningPathDetail.create(
      courses_learning_path_id: clp.id,
      talent_id: @talent.id,
      course_position: index + 1
    )
  end
end
