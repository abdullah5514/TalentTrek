

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  instructor = FactoryBot.create(:author)
  describe "GET #index" do
    it "returns a JSON response with a list of courses" do
      FactoryBot.create_list(:course, 3, instructor: instructor) # Create three courses for testing
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      
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
      course_params = FactoryBot.attributes_for(:course, instructor_attributes: { id: instructor.id, type: instructor.class.to_s })
      post :create, params: { course: course_params }
      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)["title"]).to eq(course_params[:title])
    end

    it "returns unprocessable entity with invalid attributes" do
      instructor = FactoryBot.create(:author)
      course_params = { title: nil, instructor_attributes: { id: instructor.id, type: instructor.class.to_s } }
      post :create, params: { course: course_params }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body).keys).to include("title")
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
      expect(JSON.parse(response.body).keys).to include("title")
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
