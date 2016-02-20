require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template( :index )
    end
  end

  describe "GET #show" do

    let!(:user) { Fabricate(:user) }

    context "access as a guest" do
      it "requires log_in" do
        login_with nil
        get :show, id: user.id
        expect(response).to redirect_to new_user_session_path
      end
    end
    
    context "access as logged in user" do
      it "returns http success" do
        login_with (:user)
        get :show, id: user.id
        expect(response).to have_http_status(:success)
      end
    end
  end
end