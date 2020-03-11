class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :for_guest, only: [:show, :edit, :update]
  before_action -> {restrict_access(@user.id)}, only: [:show, :edit, :update]

  def show
  end
  
  def new
    redirect_to root_path, notice:"ログアウトしてください" if logged_in?
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'User was successfully created and logged in.' }
        format.json { render :show, status: :created, locexitation: @user }
        # binding.pry
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

end
