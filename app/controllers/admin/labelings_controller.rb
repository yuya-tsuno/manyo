class Admin::LabelingsController < ApplicationController
  def create
    labeling = current_user.labelings.create(task_id: params[:task_id])
    redirect_to tasks_url, notice: "#{labeling.task.user.name}さんのブログをお気に入り登録しました"
  end
  def destroy
    labeling = current_user.labelings.find_by(id: params[:id]).destroy
    redirect_to tasks_url, notice: "#{labeling.task.user.name}さんのブログをお気に入り解除しました"
  end
end
