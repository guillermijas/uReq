class LogsController < ApplicationController
  def index
    @q = Log.all.ransack(params[:q])
    @logs = @q.result.reverse
    redirect_to projects_path unless can? :read, Log
  end
end
