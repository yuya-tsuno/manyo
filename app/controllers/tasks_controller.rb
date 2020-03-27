class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :for_guest
  before_action -> {restrict_access(@task.user_id)}, only: [:show, :edit, :update, :destroy]
  
  def index
    user_tasks = current_user.tasks
    search_tasks = user_tasks.title(params[:search_title]).status(params[:search_status]).label(params[:search_labels]).includes(:labels)

    if params[:limit_sort_expired]
      order_tasks = search_tasks.by_limit
    elsif params[:priority_sort_expired]
      order_tasks = search_tasks.by_priority
    else
      order_tasks = search_tasks.by_created_at
    end
    
    @tasks = order_tasks.page(params[:page]).per(5)
  end

  def new
    @task = Task.new
  end
  
  def create
    # @task = Task.new(task_params)
    # @task.user_id = current_user.id
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


  def show
  end

  def edit
    # binding.pry
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task.id), notice: "タスクを編集しました！"
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
      params.require(:task).permit(:id, :title, :content, :limit, :status, :priority, :user_id, {label_ids: []} )
    end

    def set_task
      @task = Task.find(params[:id])
    end

end