class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :for_guest
  before_action -> {restrict_access(@task.user_id)}, only: [:show, :edit, :update, :destroy]
  
  def index
    # binding.pry
    @q = Task.search(params[:search_title], params[:search_status], current_user.id)
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
    @labeling = current_user.labelings.find_by(label_id: @label.id)
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
      params.require(:task).permit(:id, :title, :content, :limit, :status, :priority, :user_id)
    end

    def set_task
      @task = Task.find(params[:id])
    end

end