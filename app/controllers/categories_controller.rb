class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @Category = Category.find params[:id]
  end


  private

  def category_params
    params.require(:category).permit(:name)
  end
end
