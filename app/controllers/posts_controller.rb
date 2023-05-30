class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @post = Post.new
    @post.place_id = params["place_id"]
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = @current_user.id
    if @post.save
      redirect_to "/places/#{@post["place_id"]}"
    else
      render :new
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :description, :posted_on, :place_id)
  end
  
  private

  def require_login
    unless @current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_session_path
    end
  end
end
