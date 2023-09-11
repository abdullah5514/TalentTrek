require 'rails_helper'

RSpec.describe LearningPathsController, type: :controller do
  describe "GET #index" do
    it "returns a JSON response with a list of learning paths" do
      FactoryBot.create_list(:learning_path, 3) # Create three learning paths for testing
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body).count).to eq(3)
    end
  end

  describe "GET #show" do
    it "returns a JSON response with the specified learning path" do
      learning_path = FactoryBot.create(:learning_path)
      get :show, params: { id: learning_path.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)["id"]).to eq(learning_path.id)
    end

    it "returns a not found response when the learning path is not found" do
      get :show, params: { id: 99999 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST #create" do
    it "creates a new learning path with valid attributes" do
      learning_path_params = FactoryBot.attributes_for(:learning_path)
      post :create, params: { learning_path: learning_path_params }
      expect(response.content_type).to eq('application/json; charset=utf-8')

       # Parse the JSON response body
      learning_path_response = JSON.parse(response.body)

      # Add expectations to check specific attributes of the created learning path
      expect(learning_path_response).to have_key("id")
      expect(learning_path_response["title"]).to eq(learning_path_params[:title])
      expect(learning_path_response["description"]).to eq(learning_path_params[:description])
    end

    it "returns unprocessable entity with invalid attributes" do
      learning_path_params = { title: nil }
      post :create, params: { learning_path: learning_path_params }
      expect(response).to have_http_status(:unprocessable_entity)

      error_messages = JSON.parse(response.body)
      expect(error_messages.keys).to include("title")
      expect(error_messages["title"]).to include("can't be blank")
    end
  end

  describe "PUT #update" do
    it "updates an existing learning path with valid attributes" do
      learning_path = FactoryBot.create(:learning_path)
      new_title = "Updated Title"
      put :update, params: { id: learning_path.id, learning_path: { title: new_title } }
      expect(response).to have_http_status(:ok)
    end

    it "returns unprocessable entity with invalid attributes" do
      learning_path = FactoryBot.create(:learning_path)
      put :update, params: { id: learning_path.id, learning_path: { title: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
      error_messages = JSON.parse(response.body)
      expect(error_messages.keys).to include("title")
      expect(error_messages["title"]).to include("can't be blank")
    end
  end

  describe "DELETE #destroy" do
    it "deletes an existing learning path" do
      learning_path = FactoryBot.create(:learning_path)
      delete :destroy, params: { id: learning_path.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Learning path deleted successfully")
    end

    it "returns not found when the learning path is not found" do
      delete :destroy, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
    end
  end
end
