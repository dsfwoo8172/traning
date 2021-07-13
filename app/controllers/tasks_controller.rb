class TasksController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = if params[:task] && !search_params[:keyword]
               Current.user.tasks.where(search_params).order(created_at: :desc).page(params[:page]).per(5)
             elsif params[:task] && search_params[:keyword]
               Current.user.tasks.where('title like ? or priority = ? and state = ?', "%#{search_params[:keyword]}%", Task.priorities[search_params[:priority]], Task.states[search_params[:state]])
                           .order(created_at: :desc).page(params[:page]).per(5)
             else
               Current.user.tasks.order(created_at: :desc).page(params[:page]).per(5)
             end

    if params[:sort].present?
      @tasks = Current.user.tasks.order("#{params[:sort]}").page(params[:page]).per(5)
    end
  end

  def new
    @task = Current.user.tasks.new
  end
  
  def create
    @task = Current.user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "#{@task.title} 創建成功!"
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "#{@task.title} 更新成功!"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "#{@task.title} 刪除成功!"
  end

  private

  def task_params
    params.require(:task).permit(:title, :priority, :state, :start_time, :end_time, :tag, :keyword)
  end

  def set_task
    @task = Task.find_by(id: params[:id])
  end

  def search_params
    task_params.reject{|key, val| val.blank?}
  end
end