

require 'rails_helper'

RSpec.describe TalentsController, type: :controller do
  describe "GET #index" do
    it "returns a JSON response with a list of talents" do
      FactoryBot.create_list(:talent, 3) # Create three talents for testing
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body).count).to eq(3)
    end
  end

  describe "GET #show" do
    it "returns a JSON response with the specified talent" do
      talent = FactoryBot.create(:talent)
      get :show, params: { id: talent.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)["id"]).to eq(talent.id)
    end

    it "returns a not found response when the talent is not found" do
      get :show, params: { id: 99999 }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Talent not found")
    end
  end

  describe "POST #create" do
    it "creates a new talent with valid attributes" do
      talent_params = FactoryBot.attributes_for(:talent)
      post :create, params: { talent: talent_params }
      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)["name"]).to eq(talent_params[:name])
    end

    it "returns unprocessable entity with invalid attributes" do
      talent_params = { name: nil }
      post :create, params: { talent: talent_params }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body).keys).to include("name")
    end
  end

  describe "PUT #update" do
    it "updates an existing talent with valid attributes" do
      talent = FactoryBot.create(:talent)
      new_name = "Updated Name"
      put :update, params: { id: talent.id, talent: { name: new_name } }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["name"]).to eq(new_name)
    end

    it "returns unprocessable entity with invalid attributes" do
      talent = FactoryBot.create(:talent)
      put :update, params: { id: talent.id, talent: { name: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body).keys).to include("name")
    end
  end

  describe "DELETE #destroy" do
    it "deletes an existing talent" do
      talent = FactoryBot.create(:talent)
      delete :destroy, params: { id: talent.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Talent deleted successfully")
    end

    it "returns not found when the talent is not found" do
      delete :destroy, params: { id: 99999 }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Talent not found")
    end
  end
end
