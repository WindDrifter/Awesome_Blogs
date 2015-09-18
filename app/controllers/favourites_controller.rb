class FavouritesController < ApplicationController

  before_action :authenticate_user!

  def create
    blog           = Blog.find params[:blog_id]
    favourite      = Favourite.new
    favourite.user = current_user
    favourite.blog = blog
    respond_to do |format|
      if favourite.save
        format.html { redirect_to blog, notice: "Favourited!" }
        format.js   { render }
      else
        format.html { redirect_to blog, alert: "Can't Favourited!" }
        format.js   { render }
      end
    end
  end

  def destroy
    favourite = Favourite.find params[:id]
    respond_to do |format|
      if can? :destroy, favourite
        blog = Blog.find params[:blog_id]
        favourite.destroy
        format.html { redirect_to blog_path(blog), notice: "Removed Favourite Status" }
        format.js   { render }
      else
        format.html { redirect_to root_path, alert: "Access denied" }
        format.js   { render }
      end
    end
  end

end
