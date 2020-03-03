class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  #TODO 後ほどuser_idにpresence: trueを追加します。

  def search
    @tasks = Task.where("title LIKE ?", "%#{ params[:task][:title] }%")
  end
end
