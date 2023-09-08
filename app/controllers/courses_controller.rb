class CoursesController < ApplicationController
    def index
      courses = Course.all
      render json: courses
    end
  
    def show
      course = Course.find(params[:id])
      render json: course
    end
  
    def create
      instructor =params[:course][:instructor_attributes]

      if instructor[:type].downcase == 'talent'
        instructor = Talent.find_by(id: instructor[:id].to_i)
      else 
        instructor = Author.find_by(id: instructor[:id].to_i)
      end
      course = Course.new(course_params)
      if instructor.present?
        course.instructor = instructor
      end
  
      if course.save
        render json: course, status: :created
      else
        render json: course.errors, status: :unprocessable_entity
      end
    end
  
    def update
      course = Course.find(params[:id])

      instructor = params[:course][:instructor_attributes]
      if instructor.present?
        if instructor[:type].downcase == 'talent'
          instructor = Talent.find_by(id: instructor[:id].to_i)
        else 
          instructor = Author.find_by(id: instructor[:id].to_i)
        end
        course.instructor = instructor
      end
  
      if course.update(course_params)
        render json: course
      else
        render json: course.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      course = Course.find_by(id: params[:id])

      course ? (course.destroy; render(json: { message: 'Course deleted successfully' }, status: :ok)) : (render(json: { error: 'Course not found' }, status: :not_found))
    end
  
    private
  
    def course_params
      params.require(:course).permit(:title,:description, :instructor_attributes, :course_code)
    end
  end
  