# spec/controllers/authors_controller_spec.rb

require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  describe "GET #index" do
    it "returns a JSON response with a list of authors" do
      FactoryBot.create(:author) # Create three authors for testing
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
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
      author_params = { name: nil }
      post :create, params: { author: author_params }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body).keys).to include("name")
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
      author = FactoryBot.create(:author)
      put :update, params: { id: author.id, author: { name: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body).keys).to include("name")
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
