class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(destinct: true).page(params[:page])

    respond_to do |format|
      format.html
      format.csv {send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"}
    end
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
    # head :no_content
    # flash[:notice] = "タスク「#{@task.name}」を削除しました"
    # redirect_to tasks_path
  end

  private
  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :image)
  end

end
