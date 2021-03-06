class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :for_guest
  before_action :admin?

  def index
    @users = User.select(:id, :name, :email)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_user_url(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, locexitation: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      # binding.pry
      if params[:user][:admin] == "0" && User.where(admin: true).count <= 1
        flash[:alert] = 'Admin must exist at least 1.' 
        format.html { render :edit}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      elsif @user.update(user_params)
        format.html { redirect_to admin_user_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @user.admin == true && User.where(admin: true).count <= 1
      flash[:alert] = 'Admin must exist at least 1.'
      redirect_to admin_users_path
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
  
    def set_user
      @user = User.find(params[:id])
      # binding.pry
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

end
