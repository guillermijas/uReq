class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.requirement_id = params[:requirement_id]
    @comments = Comment.where(requirement_id: params[:requirement_id], deleted: false)
    @requirement = Requirement.find(params[:requirement_id])
    @project = Project.find(params[:project_id])
    respond_to do |format|
      if @comment.save!
        Log.create(operation: 'Comentar requisito', project: @project, user: current_user, requirement: @requirement)
      end
      format.js { render layout: false }
    end
  end

  def destroy
    @comment.update(deleted: true)
    @comments = Comment.where(requirement_id: params[:requirement_id], deleted: false)
    @requirement = Requirement.find(params[:requirement_id])
    @project = Project.find(params[:project_id])
    respond_to do |format|
      Log.create(operation: 'Borrar comentario', project: @project, user: current_user, requirement: @requirement)
      format.js { render layout: false }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
