class Admin::TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :for_guest
  before_action :admin?
  
  def index
    @q = Task.search_for_admin(params[:search_title], params[:search_status])
    if params[:limit_sort_expired]
      @tasks = @q.order(limit: :asc).page(params[:page]).per(5)
    elsif params[:priority_sort_expired]
      @tasks = @q.order(priority: :asc).page(params[:page]).per(5)
    else
      @tasks = @q.order(created_at: :desc).page(params[:page]).per(5)
    end
  end

  def new
    @task = Task.new
  end  
  
  def create
    @task = current_user.tasks.build(task_params)
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
      redirect_to admin_tasks_path, notice: "タスクを編集しました！"
    else
      render :admin_edit
    end
  end

  def destroy
    @task.destroy
    redirect_to admin_tasks_path, notice:"タスクを削除しました！"
  end

  private

    def task_params
      params.require(:task).permit(:id, :title, :content, :limit, :status, :priority, :user_id)
    end

    def set_task
      @task = Task.find(params[:id])
    end

end