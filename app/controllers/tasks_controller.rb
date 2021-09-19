class TasksController < ApplicationController
  before_action :set_task, only:[:show,:edit,:update,:destroy]

  def index
      @tasks=Task.all
  end

  def show
  end

  def new
      @task=Task.new
  end

  def create
      @task=Task.new(task_params)
      if @task.save
         flash[:success]="Task投稿完了"
         redirect_to task_path(@task)
      else
          flash.now[:danger]="Taskが投稿されませんでした"
          render :new
          
      end
  end

  def edit
  end

  def update
      
      if @task.update(task_params)
         flash[:success]="Task更新完了"
         redirect_to task_path(@task)
      else
          flash.now[:danger]="Taskは更新されませんでした"
          render :edit
      end
      
  end

  def destroy
      @task.destroy
      
      flash[:success]="Task削除完了"
      redirect_to tasks_path
  end
  
  private
  
  def set_task
      @task=Task.find(params[:id])
     
  end
  
  
  def task_params
      params.require(:task).permit(:content, :status)
  end
  
  
end
