class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def new
    @comment = Comment.new
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.requirement_id = params[:requirement_id]
    @comments = Comment.where(requirement_id: params[:requirement_id])
    respond_to do |format|
      if @comment.save!
        @requirement = Requirement.find(params[:requirement_id])
        format.js { render layout: false, notice: 'Comment was successfully created.' }
      else
        format.js { render layout: false }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:body)
  end
end
