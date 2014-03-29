class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find params[:id]
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create comment_params
    redirect_to @comment
  end

  def edit
    @comment = Comment.find params[:id]
  end

  def update
    @comment = Comment.find params[:id]
    if current_user.admin?
      @comment.update comment_params
      redirect_to @comment
    else
      flash[:notice] = "You need to be an admin to do that!"
      redirect_to @comment
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    if current_user.admin?
      @comment.destroy
      redirect_to comments_path
    else
      flash[:notice] = "You need to be an admin to do that!"
      redirect_to comments_path
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content, :created_at, :updated_at, :hotspot_id
  end

end
