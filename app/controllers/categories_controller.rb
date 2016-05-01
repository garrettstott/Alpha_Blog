class CategoriesController < ApplicationController
  before_action :require_admin, only: [:new, :create, :destroy]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 7)
  end
  
  def new 
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was created successfully!"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 7)
  end
  
  def destroy
    
  end
  
  private
  
  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger] = "You do not have permission for this action!"
      redirect_to categories_path
    end
  end
  
  def category_params
    params.require(:category).permit(:name)
  end
  
end