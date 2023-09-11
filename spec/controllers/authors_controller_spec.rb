require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  describe "GET #index" do
    it "returns a JSON response with a list of authors" do
      FactoryBot.create_list(:author, 3)
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      authors = JSON.parse(response.body)
      expect(authors).to be_an(Array)
      expect(authors.length).to eq(3)
    end
  end

  describe "GET #show" do
    it "returns a JSON response with the specified author" do
      author = FactoryBot.create(:author)
      get :show, params: { id: author.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)["id"]).to eq(author.id)
    end

    it "returns a not found response when the author is not found" do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Author not found")
    end
  end

  describe "POST #create" do
    it "creates a new author with valid attributes" do
      author_params = FactoryBot.attributes_for(:author)
      post :create, params: { author: author_params }
      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)["name"]).to eq(author_params[:name])
    end

    it "returns unprocessable entity with invalid attributes" do
      author_params = { name: nil, speciality: nil, email: nil }
      post :create, params: { author: author_params }

      expect(response).to have_http_status(:unprocessable_entity)

      error_messages = JSON.parse(response.body)
      expect(error_messages.keys).to include("name", "speciality", "email")

      expect(error_messages["name"]).to include("can't be blank")
      expect(error_messages["speciality"]).to include("can't be blank")
      expect(error_messages["email"]).to include("can't be blank", "is invalid")
    end
  end

  describe "PUT #update" do
    it "updates an existing author with valid attributes" do
      author = FactoryBot.create(:author)
      new_name = "Updated Name"
      put :update, params: { id: author.id, author: { name: new_name } }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["name"]).to eq(new_name)
    end

    it "returns unprocessable entity with invalid attributes" do
      author_params = { name: nil, speciality: nil, email: nil }
      author = FactoryBot.create(:author)
      put :update, params: { id: author.id, author: author_params }
      expect(response).to have_http_status(:unprocessable_entity)

      error_messages = JSON.parse(response.body)
      expect(error_messages.keys).to include("name", "speciality", "email")

      expect(error_messages["name"]).to include("can't be blank")
      expect(error_messages["speciality"]).to include("can't be blank")
      expect(error_messages["email"]).to include("can't be blank", "is invalid")
    end
  end

  describe "DELETE #destroy" do
    it "deletes an existing author" do
      author = FactoryBot.create(:author)
      delete :destroy, params: { id: author.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Author deleted successfully")
    end

    it "returns not found when the author is not found" do
      delete :destroy, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Author not found")
    end
  end
end
