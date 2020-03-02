class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  #TODO 後ほどuser_idにpresence: trueを追加します。

  enum priority: {
    高: 0,
    中: 1,
    低: 2
  }

  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Task.where(['title LIKE ?', "%#{search}%"])
    else
      Task.all #全て表示。
    end
  end
end
