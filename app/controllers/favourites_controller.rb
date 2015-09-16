class FavouritesController < ApplicationController

  before_action :authenticate_user!

  def create
    blog           = Blog.find params[:blog_id]
    favourite      = Favourite.new
    favourite.user = current_user
    favourite.blog = blog
    if favourite.save
      redirect_to blog, notice: "Favourited!"
    else
      redirect_to blog, alert: "Can't Favourited!"
    end
  end

  def destroy
    favourite = Favourite.find params[:id]
    if can? :destroy, favourite
      blog = Blog.find params[:blog_id]
      favourite.destroy
      redirect_to blog_path(blog), notice: "Removed Favourite Status"
    else
      redirect_to root_path, alert: "Access denied"
    end
  end
  
end
