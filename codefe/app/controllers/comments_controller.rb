class CommentsController < ApplicationController

  def create
    # render text: params.inspect
    @hotspot = Hotspot.find params[:hotspot_id]
    @comment = @hotspot.comments.create comment_params
    if @comment.save
      flash[:notice] = "Comment Added!"
      redirect_to hotspot_path(@hotspot)
    else
      flash[:notice] = "Error Creating Comment"
      redirect_to hotspot_path(@hotspot)
    end
  end

  def destroy
    @hotspot = Hotspot.find params[:hotspot_id]
    @comment = Comment.find params[:id]
    @comment.destroy
    flash[:notice] = "Comment deleted!"
    redirect_to hotspot_path(@hotspot)
  end

  private
  def comment_params
    params[:comment].permit(:content, :created_at, :updated_at, :hotspot_id)
  end

end
