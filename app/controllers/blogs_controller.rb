class BlogsController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]

  before_action :authorize!, only: [:edit, :update, :destroy]

  PER_PAGE = 10

  def new
    @blog = Blog.new # Blog.new(title: "hello")
  end

  def create
    @blog = Blog.new blog_params
    @blog.user = current_user
    if @blog.save
      redirect_to blog_path(@blog), notice: "Blog Successfully created!"
    else
      flash[:alert] = "See error(s) below..."
      render "/blogs/show"
    end
  end

  def edit
    @blog  = Blog.friendly.find params[:id]
  end

  def update
    # @blog.slug = nil
    @blog  = Blog.friendly.find params[:id]
    if @blog.update blog_params
      redirect_to blog_path(@blog), notice: "Blog Successfully updated!"
    else
      flash[:alert] = "See error(s) below..."
      render :edit
    end
  end

  def destroy
    @blog  = Blog.friendly.find params[:id]
    @blog.destroy
    redirect_to blogs_path
  end

  def show
    @categories = Category.all
    @blog       = Blog.friendly.find params[:id]
    respond_to do |format|
      @comment    = Comment.new
      @like       = @blog.likes.find_by_user_id(current_user.id) if user_signed_in?
      @favourite  = @blog.favourites.find_by_user_id(current_user.id) if user_signed_in?
      format.html { render }
      format.json { render json: @blog }
    end
  end

  def index
    @blogs = Blog.page(params[:page]).per(PER_PAGE)
  end


  private

  def authorize!
    # head :unauthorized unless can? :manage, @blog
    redirect_to root_path, alert: "access denied" unless can? :manage, @blog
  end

  def blog_params
    params.require(:blog).permit([:title, :body, :image,
                                 {tag_ids: []},
                                 :category_id, :created_at])
  end
end
