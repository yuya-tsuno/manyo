class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    if params[:limit_sort_expired]
      @tasks = Task.search(params[:search_title], params[:search_status]).order(limit: :asc)
    elsif params[:priority_sort_expired]
      @tasks = Task.search(params[:search_title], params[:search_status]).order(priority: :asc)
    else
      @tasks = Task.search(params[:search_title], params[:search_status]).order(created_at: :desc)
    end
  end

  def new
    @task = Task.new
  end  
  
  def create
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

end
