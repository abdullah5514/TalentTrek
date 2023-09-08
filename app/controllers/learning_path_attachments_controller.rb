class LearningPathAttachmentsController < ApplicationController
    before_action :find_learning_path, only: [:create]
    before_action :find_talent, only: [:create]
    before_action :find_assignment, only: [:destroy]
  
    def create
      # Assign the learning path to the talent using LearningPathsTalent
      @assignment = LearningPathsTalent.new(learning_path: @learning_path, talent: @talent)
  
      if @assignment.save
        if learning_path_has_course
          create_course_learning_path_details
        end
  
        render json: { message: "Learning path assigned to talent successfully." }, status: :created
      else
        render json: { error: "Failed to assign learning path to talent." }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @assignment.destroy
      head :no_content
    end
  
    private
  
    def find_learning_path
      @learning_path = LearningPath.find(params[:learning_path_id])
    end
  
    def find_talent
      @talent = Talent.find(params[:talent_id])
    end
  
    def find_assignment
      @assignment = LearningPathsTalent.find(params[:id])
    end
  
    def learning_path_has_course
      @learning_path.courses.present?
    end
  
    def create_course_learning_path_details
      @learning_path.courses.each do |course|
        CourseLearningPathDetail.create(
          courses_learning_path_id: course.id,
          talent_id: @talent.id,
          status: 'in_progress' # You can set the initial status here
        )
      end
    end
  end
  