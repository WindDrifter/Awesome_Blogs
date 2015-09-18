class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    blog      = Blog.find params[:blog_id]
    like      = Like.new
    like.user = current_user
    like.blog = blog
    respond_to do |format|
      if like.save
        format.html { redirect_to blog, notice: "Liked!" }
        format.js   { render }
      else
        format.html { redirect_to blog, alert: "Can't like" }

      end
    end
  end

  def destroy
    like = Like.find params[:id]
    respond_to do |format|
      if can? :destroy, like
        blog = Blog.find params[:blog_id]
        like.destroy
        format.html { redirect_to blog_path(blog), notice: "Un-liked" }
        format.js   { render }
      else
        format.html { redirect_to root_path, alert: "Access denied" }
        format.js   { render }
      end
    end
  end

end
