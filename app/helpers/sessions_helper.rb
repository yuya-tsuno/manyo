module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in? #ログインの有無をチェック
    current_user.present?
  end

  def for_guest #未ログインユーザー（ゲスト）へのアクセス制限
    redirect_to new_session_path, notice: "ログインしてください" unless logged_in?
  end

  def have_access_right?(user_id) #アクセス権限の有無をチェック
    current_user
    user_id == @current_user.id
  end

  def restrict_access #アクセス権限のないユーザーへのアクセス制限
    unless have_access_rights?
      flash[:notice] = "あなたのアカウントではアクセス権限がありません"
      redirect_to tasks_path
    end
  end

end
