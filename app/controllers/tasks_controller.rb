class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:index, :show]

  def index
    if logged_in?
      @tasks = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
     @task = Task.new(task_params)
     
    if @task.save
      flash[:success] = 'タスクが正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが登録されませんでした'
      render :new
    end
  end
  
  def edit
    
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは登録されませんでした'
      render :edit
    end
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content,:status)
  end
end