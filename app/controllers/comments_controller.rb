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
    @requirement = Requirement.find(params[:requirement_id])
    @project = Project.find(params[:project_id])
    respond_to do |format|
      if @comment.save!
        Log.new(operation: "#{current_user.full_name} ha comentado el requisito '#{@requirement.id_string}'",
                project_name: @project.name, user_name: current_user.short_name).save!
      end
      format.js { render layout: false }
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    @comments = Comment.where(requirement_id: params[:requirement_id])
    @requirement = Requirement.find(params[:requirement_id])
    @project = Project.find(params[:project_id])
    respond_to do |format|
      Log.new(operation: "#{current_user.full_name} ha borrado un comentario en el requisito '#{@requirement.id_string}'",
              project_name: @project.name, user_name: current_user.short_name).save!
      format.js { render layout: false }
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
