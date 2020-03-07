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

  def have_access_right?(check_id) #アクセス権限の有無をチェック
    current_user
    check_id == @current_user.id
  end

  def restrict_access(check_id) #アクセス権限のないユーザーへのアクセス制限
    unless have_access_right?(check_id)
      flash[:notice] = "あなたのアカウントではアクセス権限がありません"
      redirect_to tasks_path
    end
  end

  def admin?
    if current_user&.admin?
      @admin = current_user.name
    else
      flash[:notice] = "あなたのアカウントは管理者権限がありません"
      redirect_to tasks_path
    end
  end

end
