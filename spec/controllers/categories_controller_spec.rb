require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  
  let(:admin) { Fabricate(:user, admin: true) }
  let(:non_admin) { Fabricate(:user, admin: false) }
  let(:category) { Fabricate(:category, name: "Programming") }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template( :index )
    end
  end

  describe "GET #show" do

    let(:category) { Fabricate(:category, name: "Sports") }
  
    it "returns http success" do
      get :show, id: category.id
      expect(response).to have_http_status(:success)
    end
  end
  
  before { login_with (admin) }
  
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
  
    context "non admin creating a category" do
      
      before do login_with (non_admin)
        post :create, category: Fabricate.attributes_for(:category, name: "Cooking") 
      end
      
      it "redirects to index template" do 
        expect(response).to redirect_to categories_path
      end

      it "displays the flash message" do 
        expect(flash[:danger]).to eq("Only admin users can perform that action")
      end
    end
      
    context "admin creates a category" do
      
      before { login_with (admin) }
      
      context "a successful create" do
      
        before do
          post :create, category: Fabricate.attributes_for(:category, name: "Cooking")
        end
      
        it "saves a post object in database" do
          expect(Category.count).to eq(1)
        end

        it "displays a flash message" do
          expect(flash[:success]).to eq("Category has been created")
        end

        it "redirects to show page" do
          expect(response).to redirect_to category_path(Category.last)
        end
      end

      context "an unsuccessful create" do
      
        before do
          post :create, category: Fabricate.attributes_for(:category, name: " ")
        end
      
        it "saves a post object in database" do
          expect(Category.count).to eq(0)
        end

        it "redirects to new page" do
          expect(response).to render_template(:new)
        end
      end  
    end
  end

  describe "PUT #update" do
  
    context "non admin updates a category" do
      
      before do 
        login_with (non_admin)
        put :update, category: Fabricate.attributes_for(:category, name: "Cooking"),
                     id: category
      end
      
      it "redirects to index template" do 
        expect(response).to redirect_to categories_path
      end

      it "displays the flash message" do 
        expect(flash[:danger]).to eq("Only admin users can perform that action")
      end
    end
      
    context "admin updates a category" do
      
      before { login_with (admin) }
      
      context "a successful create" do
      
        before do
          put :update, category: Fabricate.attributes_for(:category, name: "Cooking"),
                       id: category
        end
      
        it "saves a post object in database" do
          expect(Category.count).to eq(1)
        end

        it "displays a flash message" do
          expect(flash[:success]).to eq("Category has been updated")
        end

        it "redirects to show page" do
          expect(response).to redirect_to category_path(Category.last)
        end
      end

      context "an unsuccessful create" do
      
        before do
          post :create, category: Fabricate.attributes_for(:category, name: " ")
        end
      
        it "saves a post object in database" do
          expect(Category.count).to eq(0)
        end

        it "redirects to new page" do
          expect(response).to render_template(:new)
        end
      end  
    end
  end

  describe "DELETE #destroy" do

    let(:category) { Fabricate(:category, name: "Arts")}
    
    before do
      delete :destroy, id: category
    end

    it "deletes post object" do
      expect(Category.count).to eq(0)
    end

    it "displays flash message" do
      expect(flash[:success]).to eq("Category has been destroyed")
    end

    it "redirects to index page of posts" do
      expect(response).to redirect_to categories_path
    end
  end
end