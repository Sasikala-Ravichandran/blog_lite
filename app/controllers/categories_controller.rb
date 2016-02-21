class CategoriesController < ApplicationController

  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    number = user_signed_in? ? 3 : 5
    @categories= Category.paginate(page: params[:page], per_page: number)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category has been created"
      redirect_to category_path(@category)
    else
      render "new"
    end
  end

  def show
    @category_posts = @category.posts.paginate(page: params[:page], per_page: 3)
  end
  
  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category has been updated"
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = "Category has been destroyed"
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
     @category = Category.find(params[:id])
  end
  def require_admin
    if user_signed_in? && !current_user.admin?
      flash[:danger] = "Only admin users can perform that action"
      redirect_to categories_path
    end
  end
end
