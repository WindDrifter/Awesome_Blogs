class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    blog      = Blog.find params[:blog_id]
    like      = Like.new
    like.user = current_user
    like.blog = blog
    if like.save
      redirect_to blog, notice: "Liked!"
    else
      redirect_to blog, alert: "Can't like"
    end
  end

  def destroy
    like = Like.find params[:id]
    if can? :destroy, like
      blog = Blog.find params[:blog_id]
      like.destroy
      redirect_to blog_path(blog), notice: "Un-liked"
    else
      redirect_to root_path, alert: "Access denied"
    end
  end

end
