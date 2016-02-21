class PostsController < ApplicationController

  before_action :set_user, only: [:new, :create, :edit, :update]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update]

  def index
    number = user_signed_in? ? 2 : 3
    @posts = Post.paginate(page: params[:page], per_page: number)
  end

  def show

  end

  def new
    @post = @user.posts.build
  end

  def create
    @post = @user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post has been created successfully"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post has been updated successfully"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post has been destroyed"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, category_ids: [])
  end
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
  def set_post
    @post = Post.find(params[:id])
  end

  def require_same_user
    if current_user != @post.user && !current_user.admin?
      flash[:danger] = "You do not have authorization to do this!"
      redirect_to root_path
    end
  end
end