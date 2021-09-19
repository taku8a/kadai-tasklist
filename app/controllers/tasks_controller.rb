class TasksController < ApplicationController
  def index
      @tasks=Task.all
  end

  def show
      @task=Task.find(params[:id])
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
      @task=Task.find(params[:id])
  end

  def update
      @task=Task.find(params[:id])
      if @task.update(task_params)
         flash[:success]="Task更新完了"
         redirect_to task_path(@task)
      else
          flash.now[:danger]="Taskは更新されませんでした"
          render :edit
      end
      
  end

  def destroy
      @task=Task.find(params[:id])
      @task.destroy
      
      flash[:success]="Task削除完了"
      redirect_to tasks_path
  end
  
  private
  
  def task_params
      params.require(:task).permit(:content)
  end
  
  
end
