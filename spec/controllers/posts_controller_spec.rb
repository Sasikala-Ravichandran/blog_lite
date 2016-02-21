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

  before { login_with (user) }
  
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
        expect(flash[:success]).to eq("Post has been created successfully")
      end

      it "redirects to show page" do
        expect(response).to redirect_to post_path(Post.last)
      end

    end

    context "an unsuccessful create" do
      before do
        post :create, post: Fabricate.attributes_for(:post, title: " "), user_id: user.id
      end
      
      it "saves a post object in database" do
        expect(Post.count).to eq(0)
      end

      it "redirects to new page" do
        expect(response).to render_template(:new)
      end

    end
  end

  describe "GET #edit" do
    let(:post) { Fabricate(:post) }
    
    context "edits user's own post" do
      it "returns http success" do
        login_with ( post.user )
        get :edit, id: post.id, user_id: post.user.id
        #require 'pry'; binding.pry
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
      end
    end

    context "edits other user's post" do

      before { login_with (user) }
      it "displays error message" do        
        get :edit, id: post.id, user_id: post.user.id
        expect(response).to redirect_to root_path
      end

      it "redirected to root_path" do
        get :edit, id: post.id, user_id: post.user.id
        expect(flash[:danger]).to eq("You do not have authorization to do this!")
      end
    end
  end

  describe "PUT #update" do
    let(:post) { Fabricate(:post, title: "Amazing Post")}

    context "updates user's own post" do
      context "a successful update" do
        before do
          login_with ( post.user )
          put :update, post: Fabricate.attributes_for(:post, title: "Awesome Post"),
                     id: post, user_id: post.user.id
        end
      
        it "saves a post object in database" do
          expect(Post.last.title).to eq("Awesome Post")
        end

        it "displays a flash message" do
          expect(flash[:success]).to eq("Post has been updated successfully")
        end

        it "redirects to show page" do
          expect(response).to redirect_to post_path(Post.last)
        end
      end

      context "an unsuccessful update" do
        before do
          login_with ( post.user )
          put :update, post: Fabricate.attributes_for(:post, title: " "),
                     id: post, user_id: post.user.id
        end
      
        it "saves a post object in database" do
          expect(Post.last.title).to eq("Amazing Post")
        end

        it "redirects to show page" do
          expect(response).to render_template(:edit)
        end

      end
    end

    context "updates other user's post" do

      before { login_with (user) }
      
      it "displays error message" do
        put :update, post: Fabricate.attributes_for(:post, title: " "),
                     id: post, user_id: post.user.id
        expect(response).to redirect_to root_path
      end

      it "redirected to root_path" do
        put :update, post: Fabricate.attributes_for(:post, title: " "),
                     id: post, user_id: post.user.id
        expect(flash[:danger]).to eq("You do not have authorization to do this!")
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
