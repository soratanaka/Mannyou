class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
#    @task.user_id = current_user.id 
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render :new
    end
  end

  def index
    if params[:finish_expired]
      @tasks = current_user.tasks.order(finish_on: :desc).page(params[:page])
    elsif params[:priority_expired]
      @tasks = current_user.tasks.order(priority: :asc).page(params[:page])
    else
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page])
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
    if params[:label_id].present?
      @tasks = Label.find(params[:label_id]).tasks.page(params[:page])
    else
      @tasks = current_user.tasks.looks(params[:status], params[:name_cont]).page(params[:page])
    end
  end
  


  private

  def task_params
    params.require(:task).permit(:name, :content, :finish_on, :status, :priority, label_ids: []).merge(user_id:current_user.id)
  end
end
