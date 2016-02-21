class UsersController < ApplicationController

  before_action :require_admin, only: [:destroy]

  def index
    number = user_signed_in? ? 2 : 3
    @users = User.paginate(page: params[:page], per_page: number)
  end
  
  def show
    @user = User.find(params[:id])
    @user_posts = @user.posts.paginate(page: params[:page], per_page: 2)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
      flash[:success] = "Blogger has been deleted"
      redirect_to users_path
  end

  private

  def set_user
  end

  def require_admin
    if user_signed_in? && !current_user.admin?
      flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
    end
  end
end
