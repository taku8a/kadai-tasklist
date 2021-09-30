class TasksController < ApplicationController
  before_action :set_task, only:[:show,:edit,:update,:destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  

  def index
    if logged_in?
      @task = current_user.tasks.build
      @pagy,@tasks = pagy(current_user.tasks.order(id: :desc))
    end
    
  end

  def show
  end

  def new
      @task=Task.new
  end

  def create
      @task=current_user.tasks.build(task_params)
      if @task.save
         flash[:success]="Task投稿完了"
         redirect_to root_url
      else
          @pagy,@tasks = pagy(current_user.tasks.order(id: :desc))
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
      redirect_to root_path
  end
  
  private
  
  def set_task
      @task=Task.find_by(id: params[:id])
     
  end
  
  
  def task_params
      params.require(:task).permit(:content, :status)
  end
  
  def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
          redirect_to root_url
      end
  end
  
  
end
