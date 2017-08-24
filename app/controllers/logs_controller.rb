class LogsController < ApplicationController
  def index
    @q = Log.all.ransack(params[:q])
    @logs = @q.result
  end
end
