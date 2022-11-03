class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :autheniticate_user, {only: [:edit, :update]}
  before_action :ensure_current_user, {only: [:edit, :update, :show]}
  before_action :login_now , {only: [:new]}

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end
  

  private

  def user_params
    params.require(:user).permit(:id, :name, :email, :password,
                                :password_confirmation)
  end

  def ensure_current_user
    if @current_user.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to tasks_path
    end
  end

  def login_now
    if @current_user 
      flash[:notice]="ログイン中です"
      redirect_to user_path(current_user.id)
    end
  end
end
