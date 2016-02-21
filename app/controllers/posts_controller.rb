class PostsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    if @post.save
      flash[:sucess] = "Post has been created successfully"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])

  end

  def update
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:sucess] = "Post has been updated successfully"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "Post has been destroyed"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end
  
end