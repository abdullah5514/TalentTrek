class CoursesController < ApplicationController
    def index
      courses = Course.all
      render json: courses
    end
  
    def show
      course = Course.find_by(id: params[:id])
      if course
        render json: course
      else
        render json: { error: 'Course not found' }, status: :not_found
      end
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
      # Find the course by its ID
      course = Course.find(params[:id])

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
        course.instructor = instructor
      end

      # Attempt to update the course with the provided parameters
      if course.update(course_params)
        render json: course
      else
        # If the update fails, render the course errors as JSON with a 422 status
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
  