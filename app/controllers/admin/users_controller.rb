class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザー「#{@user.name}」を登録しました"
      redirect_to admin_user_path(@user)
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      flash[:notice] = "ユーザー「#{@user.name}」を登録しました"
      redirect_to admin_user_path(@user)
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー「#{@user.name}」を更新しました"
      redirect_to admin_user_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    flash[:notice] = "ユーザー「#{@user.name}」を削除しました"
    @user.destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end
end
