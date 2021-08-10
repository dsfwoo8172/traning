class TasksController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Current.user.tasks
    @tasks = @tasks.without_keyword(search_params) if params[:task] && !search_params[:keyword] && !search_params[:tag]
    @tasks = @tasks.with_keyword(search_params) if params[:task] && search_params[:keyword] && !search_params[:tag]
    @tasks = @tasks.with_tag_and_without_keyword(search_params[:tag], search_params) if params[:task] && search_params[:tag] && !search_params[:keyword]
    @tasks = @tasks.with_tag_and_with_keyword(search_params[:tag], search_params) if params[:task] && search_params[:tag] && search_params[:keyword]
    
    @tasks = @tasks.order(id: :desc).page(params[:page]).per(5)

    if params[:sort].present?
      @tasks = @tasks.reorder("#{params[:sort]}")
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
    params.require(:task).permit(:title, :priority, :state, :start_time, :end_time, :keyword, :content, tag_list: [])
  end

  def search_params
    params[:task].reject{|key, val| val.blank?}
  end

  def set_task
    @task = Task.find_by(id: params[:id])
  end
end