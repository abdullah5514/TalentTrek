require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  instructor = FactoryBot.create(:author)
  describe "GET #index" do
    it "returns a JSON response with a list of courses" do
      FactoryBot.create_list(:course, 3, instructor: instructor) # Create three courses for testing
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      courses = JSON.parse(response.body)
      expect(courses).to be_an(Array)
      expect(courses.length).to eq(3)
    end
  end

  describe "GET #show" do
    it "returns a JSON response with the specified course" do
      course = FactoryBot.create(:course, instructor: instructor)
      get :show, params: { id: course.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)["id"]).to eq(course.id)
    end

    it "returns a not found response when the course is not found" do
      get :show, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Course not found")
    end
  end

  describe "POST #create" do
    it "creates a new course with valid attributes" do
      instructor = FactoryBot.create(:author) # Create a test instructor
      course_params = FactoryBot.attributes_for(:course, instructor_type: instructor.class.to_s, instructor_id: instructor.id)
      
      post :create, params: { course: course_params }

      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      course_response = JSON.parse(response.body)
      created_course = Course.find(course_response["id"]) # Assuming the response includes the ID of the created course

      # Verify that the course attributes match the provided attributes
      expect(created_course.title).to eq(course_params[:title])
      expect(created_course.description).to eq(course_params[:description])
      expect(created_course.instructor_type).to eq(course_params[:instructor_type])
      expect(created_course.instructor_id).to eq(course_params[:instructor_id])
      expect(created_course.course_code).to eq(course_params[:course_code])
    end

    it "returns unprocessable entity with invalid attributes" do
      instructor = FactoryBot.create(:author)
      course_params = { title: nil, start_date: nil,
                        description: nil, end_date: nil,
                        course_code: nil, instructor_type: instructor.class.to_s,
                        instructor_id: instructor.id }
      post :create, params: { course: course_params }
      expect(response).to have_http_status(:unprocessable_entity)

      error_messages = JSON.parse(response.body)
      expect(error_messages.keys).to include("title")
      expect(error_messages["title"]).to include("can't be blank")
    end    
  end

  describe "PUT #update" do
    it "updates an existing course with valid attributes" do
      instructor = FactoryBot.create(:author) # Create a test instructor
      course = FactoryBot.create(:course, instructor: instructor)
      new_title = "Updated Title"
      put :update, params: { id: course.id, course: { title: new_title, instructor_attributes: { id: instructor.id, type: instructor.class.to_s } } }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["title"]).to eq(new_title)
    end

    it "returns unprocessable entity with invalid attributes" do
      instructor = FactoryBot.create(:author)
      course = FactoryBot.create(:course, instructor: instructor )
      put :update, params: { id: course.id, course: { title: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
      error_messages = JSON.parse(response.body)
      expect(error_messages.keys).to include("title")
      expect(error_messages["title"]).to include("can't be blank")
    end
  end

  describe "DELETE #destroy" do
    it "deletes an existing course" do
      instructor = FactoryBot.create(:author)
      course = FactoryBot.create(:course, instructor: instructor)
      delete :destroy, params: { id: course.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Course deleted successfully")
    end

    it "returns not found when the course is not found" do
      delete :destroy, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Course not found")
    end
  end
end
