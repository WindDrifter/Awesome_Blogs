class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @blog             = Blog.friendly.find params[:blog_id]
    # @comment        = @blog.comments.new comment_params
    @comment          = Comment.new comment_params
    @comment.blog     = @blog
    @comment.user     = current_user
    respond_to do |format|
      if @comment.save
        CommentsMailer.delay(run_at: 5.minutes.from_now).notify_blog_owner(@comment)
        format.html { redirect_to blog_path(@blog), notice: "Comment Created!" }
        format.js   { render :create_success }
      else
        format.html do
          flash[:alert] = "Comment wasn't created"
          render "/blogs/show"
        end
        format.js   { render js: "alert(\"answer didn't save correctly!\");" }
      end
    end
  end

  def destroy
    @blog = Blog.friendly.find params[:blog_id]
    @comment = Comment.find params[:id]
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to blog_path(@blog), notice: "Comment deleted." }
      format.js   { render }
    end
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
