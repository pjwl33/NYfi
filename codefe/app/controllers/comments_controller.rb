class CommentsController < ApplicationController
  #creating a comment within a nested hotspot
  before_action :authenticate

  ###is this still too much logic with the Controller even though it's mostly UI??

  def create
    @hotspot = Hotspot.find params[:hotspot_id]
    @comment = @hotspot.comments.create comment_params
    if @comment.save
      redirect_to hotspot_path(@hotspot), notice: "Comment Added!"
    else
      redirect_to hotspot_path(@hotspot), notice: "Error Creating Comment"
    end
  end
  #destroying a comment within hotspot
  def destroy
    if admin?
      @hotspot = Hotspot.find params[:hotspot_id]
      @comment = Comment.find params[:id]
      @comment.destroy
      redirect_to hotspot_path(@hotspot), notice:  "Comment deleted!"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :created_at, :updated_at, :hotspot_id)
  end

end
