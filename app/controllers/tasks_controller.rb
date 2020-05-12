class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = current_user.tasks.recent
  end

  def show
  end

  def new
    @task = Task.new
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render 'new' unless @task.valid?
  end

  def create
    @task = current_user.tasks.new(task_params)

    if params[:back].present?
      render 'new'
      return
    end

    if @task.save
      flash[:notice] = "タスク「#{@task.name}」を保存しました"
      redirect_to tasks_path
    else 
      render 'new'
    end
  end

  def edit
  end

  def update
    @task.update!(task_params)
    flash[:notice] = "タスク「#{@task.name}」を更新しました"
    redirect_to tasks_path
  end

  def destroy
    @task.destroy
    flash[:notice] = "タスク「#{@task.name}」を削除しました"
    redirect_to tasks_path
  end

  private
  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description)
  end

end
