class UsersController < ApplicationController

  def index
    number = user_signed_in? ? 2 : 3
    @users = User.paginate(page: params[:page], per_page: number)
  end
  
  def show
    @user = User.find(params[:id])
    @user_posts = @user.posts.paginate(page: params[:page], per_page: 2)
  end

end
