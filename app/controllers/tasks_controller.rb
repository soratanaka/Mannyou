class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
#    @task.user_id = current_user.id 
    if @task.save
      redirect_to tasks_path, notice: "ブログを作成しました！"
    else
      render :new
    end
  end

  def index
    if params[:finish_expired]
      @tasks = Task.all.order(finish_on: :desc)
    elsif params[:priority_expired]
      @tasks = Task.all.order(priority: :asc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
  redirect_to tasks_path, notice:"ブログを削除しました！"
  end

  def search
    @tasks = Task.looks(params[:status], params[:name_cont])
  end
  


  private

  def task_params
    params.require(:task).permit(:name, :content, :finish_on, :status, :priority)
  end
end
