class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @q = Task.ransack(params[:q])
    @tasks = @q.result(distinct: true)
  end

  def new
    @task = Task.new
  end  
  
  def create
    # binding.pry
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to task_path(@task.id), notice: "タスクを作成しました！"
      else
        render :new
      end  
    end  
  end  

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:id, :title, :content, :limit, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def search_params
    params.require(:q).permit!
  end

end
