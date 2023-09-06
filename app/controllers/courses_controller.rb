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
      course = Course.new(course_params)
  
      if course.save
        render json: course, status: :created
      else
        render json: course.errors, status: :unprocessable_entity
      end
    end
  
    def update
      course = Course.find(params[:id])
  
      if course.update(course_params)
        render json: course
      else
        render json: course.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      course = Course.find(params[:id])
      course.destroy
      head :no_content
    end
  
    private
  
    def course_params
      params.require(:course).permit(:title, :author_id)
    end
  end
  