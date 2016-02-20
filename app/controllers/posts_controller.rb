class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
  end

  def show
    @post = Post.find(params[:id])
  end

end