class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create

    @blog             = Blog.find params[:blog_id]
    # @comment        = @blog.comments.new comment_params
    @comment          = Comment.new comment_params
    @comment.blog     = @blog
    @comment.user     = current_user
      if @comment.save
        CommentsMailer.notify_blog_owner(@comment).deliver_now
        redirect_to blog_path(@blog), notice: "Comment Created!"
      else
        flash[:alert] = "Comment wasn't created"
        render "/blogs/show"
      end
  end

  def destroy
    @blog = Blog.find params[:blog_id]
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to blog_path(@blog), notice: "Comment deleted."
  end

  # def edit
  #   @comment = Comment.find params[:id]
  # end
  #
  # def update
  #   @blog = Blog.find params[:blog_id]
  #   @comment = Comment.find params[:id]
  #   if @comment.update comment_params
  #     redirect_to blog_path(@blog), notice: "Comment Updated!"
  #   else
  #     flash[:alert] = "Comment wasn't created"
  #     render "/blogs/show"
  #   end
  # end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
