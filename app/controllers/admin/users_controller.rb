class Admin::UsersController < ApplicationController
  before_action :admin_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザーを作成しました！"
    else
      render :new
    end
  end

  def index
    @users = User.all.order("created_at DESC").page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @tasks = Task.user_tasks(params[:id]).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザーを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice:"ユーザーを削除しました！"
    else
      redirect_to admin_users_path, notice:"ユーザーを削除できません！(管理者が残りあなただけです)"
    end
  end

  private

  def user_params
    params.require(:user).permit(:id,:admin, :name, :email, :password,
                                :password_confirmation)
  end

  def admin_user
    unless current_user.admin?
      flash[:notice]="権限がありません"
      redirect_to(tasks_path) 
    end
  end
end
