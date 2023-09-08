class LearningPathAttachmentsController < ApplicationController
    before_action :find_learning_path, only: [:create]
    before_action :find_talent, only: [:create]
    before_action :find_assignment, only: [:destroy]
  
    def create
      # Assign the learning path to the talent using LearningPathsTalent
      @assignment = LearningPathTalent.new(learning_path: @learning_path, talent: @talent)
      if @assignment.save
        render json: { message: "Learning path assigned to talent successfully." }, status: :created
      else
        render json: { error: "Failed to assign learning path to talent." }, status: :unprocessable_entity
      end
  
      if @learning_path.courses.present?
        create_course_learning_path_details
      end
    end
  
    def destroy
      @assignment.destroy
      head :no_content
    end
  
    private
  
    def find_learning_path
      @learning_path = LearningPath.find_by(id: params[:learning_path_id])
    end
  
    def find_talent
      @talent = Talent.find_by(id: params[:talent_id])
    end
  

    def create_course_learning_path_details
      courses_learning_paths = @learning_path.courses_learning_paths.order(:id)
      courses_learning_paths.each_with_index do |clp, index|
        CourseLearningPathDetail.create(
          courses_learning_path_id: clp.id,
          talent_id: @talent.id,
          course_position: index + 1 # Add 1 to index to start counting from 1
        )
      end
    end
    
  end
  