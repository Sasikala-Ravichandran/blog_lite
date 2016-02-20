require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  
  let(:user) { Fabricate(:user) }
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  before { login_with (:user) }
  
  describe "GET #show" do
    let(:post) { Fabricate(:post) }
    it "returns http success" do
      get :show, id: post.id, user_id: user.id
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, user_id: user.id
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do

    context "a successful create" do
      before do
        post :create, post: Fabricate.attributes_for(:post), user_id: user.id
      end
      
      it "saves a post object in database" do
        expect(Post.count).to eq(1)
      end

      it "displays a flash message" do
        expect(flash[:sucess]).to eq("Post has been created successfully")
      end

      it "redirects to show page" do
        expect(response).to redirect_to user_post_path(user, Post.last)
      end

    end

    context "an unsuccessful create" do
      before do
        post :create, post: Fabricate.attributes_for(:post, title: " "), user_id: user.id
      end
      
      it "saves a post object in database" do
        expect(Post.count).to eq(0)
      end

      it "redirects to show page" do
        expect(response).to render_template(:new)
      end

    end
  end

  describe "GET #edit" do
    let(:post) { Fabricate(:post) }
    it "returns http success" do
      get :edit, id: post.id, user_id: user.id
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT #update" do
    let(:post) { Fabricate(:post, title: "Amazing Post")}

    context "a successful update" do
      before do
        put :update, post: Fabricate.attributes_for(:post, title: "Awesome Post"),
                     id: post, user_id: user.id
      end
      
      it "saves a post object in database" do
        expect(Post.last.title).to eq("Awesome Post")
      end

      it "displays a flash message" do
        expect(flash[:sucess]).to eq("Post has been updated successfully")
      end

      it "redirects to show page" do
        expect(response).to redirect_to user_post_path(user, Post.last)
      end

    end

    context "an unsuccessful update" do
      before do
        put :update, post: Fabricate.attributes_for(:post, title: " "),
                     id: post, user_id: user.id
      end
      
      it "saves a post object in database" do
        expect(Post.last.title).to eq("Amazing Post")
      end

      it "redirects to show page" do
        expect(response).to render_template(:edit)
      end

    end
  end

  describe "DELETE #destroy" do

    let(:post) { Fabricate(:post)}
    before do
      delete :destroy, id: post, user_id: user.id
    end

    it "deletes post object" do
      expect(Post.count).to eq(0)
    end

    it "displays flash message" do
      expect(flash[:success]).to eq("Post has been destroyed")
    end

    it "redirects to index page of posts" do
      expect(response).to redirect_to posts_path
    end
  end
  
end
