require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  
  let(:user) { Fabricate(:user) }
  let(:post) { Fabricate(:post) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      login_with (:user)
      get :show, id: post.id, user_id: user.id
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end
  
end