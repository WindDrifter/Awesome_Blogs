class VotesController < ApplicationController

  before_action :authenticate_user!

  def create
    blog       = Blog.friendly.find params[:blog_id]
    vote       = Vote.new vote_params
    vote.user  = current_user
    vote.blog  = blog
    if vote.save
      redirect_to blog, notice: "Voted!"
      else
      redirect_to blog, alert: "Can't Vote!"
    end
  end

  def update
    blog       = Blog.friendly.find params[:blog_id]
    vote       = Vote.find params[:id]
    if !(can? :update, vote)
      redirect_to root_path, alert: "access denied"
    elsif vote.update vote_params
      redirect_to blog, notice: "Vote updated"
    else
      redirect_to blog, alert: "Vote was not updated"
    end
  end

  def destroy
    vote = Vote.find params[:id]
    if can? :destroy, vote
      vote.destroy
      blog = Blog.friendly.find params[:blog_id]
      redirect_to blog, notice: "Vote removed!"
    else
      redirect_to root_path, alert: "access denied"
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:up)
  end
end
