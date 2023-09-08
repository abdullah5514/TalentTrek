# app/controllers/course_assignments_controller.rb
class CourseAssignmentsController < ApplicationController
    before_action :find_talent, only: [:assign_talent_to_course]
    before_action :find_course, only: [:assign_talent_to_course]
    before_action :find_learning_path, only: [:assign_course_to_learning_path]
  
    def assign_talent_to_course
        if @talent && @course
          if !@course.talents.include?(@talent)
            @course.talents << @talent
            render json: { message: 'Talent assigned to the course successfully' }
          else
            render json: { error: 'Talent is already assigned to the course' }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Talent or course not found' }, status: :not_found
        end
    end
  
    def assign_course_to_learning_path
      if @course && @learning_path
        if !@learning_path.courses.include?(@course)
          @learning_path.courses << @course
          render json: { message: 'Course assigned to the learning path successfully' }
        else
          render json: { error: 'Course is already assigned to the learning path' }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Course or learning path not found' }, status: :not_found
      end
    end
  
    private
  
    def find_talent
      # Existing code for finding talent
      @talent = Talent.find_by(id: params[:talent_id])
    end
  
    def find_course
      @course = Course.find_by(id: params[:course_id])
    end
  
    def find_learning_path
      @learning_path = LearningPath.find_by(id: params[:learning_path_id])
    end
  end
  