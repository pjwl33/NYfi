class CommentsController < ApplicationController

  def create
    # render text: params.inspect
    # @hotspot = Hotspot.find params[:hotspot_id]
    @comment = Comment.new comment_params
    if @comment.save
      flash[:notice] = "Comment Added!"
      redirect_to @comment.hotspot
    else
      flash[:notice] = "Error Creating Comment"
      redirect_to @comment.hotspot
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    flash[:notice] = "Comment deleted!"
    redirect_to @comment.hotspot
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :created_at, :updated_at, :hotspot_id)
  end

end
