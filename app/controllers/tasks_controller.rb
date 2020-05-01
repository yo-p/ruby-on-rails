class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)
    task.save!
    flash[:notice] = "タスク「#{task.name}」を保存しました"
    redirect_to tasks_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    flash[:notice] = "タスク「#{task.name}」を更新しました"
    redirect_to tasks_path
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    flash[:notice] = "タスク「#{task.name}」を削除しました"
    redirect_to tasks_path
  end

  private
  def task_params
    params.require(:task).permit(:name, :description)
  end

end
