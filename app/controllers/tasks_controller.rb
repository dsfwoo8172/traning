class TasksController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_task, only: %i[show edit update destroy]
  include ActionView::RecordIdentifier

  def index
    @tasks = Current.user.tasks

    if params[:task]
      @tasks = @tasks.tagged_with(search_params[:tag]) if search_params[:tag]
      @tasks = @tasks.with_state(search_params[:state]) if search_params[:state]
      @tasks = @tasks.with_priority(search_params[:priority]) if search_params[:priority]
      @tasks = @tasks.with_keyword(search_params[:keyword]) if search_params[:keyword]
    end

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
    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: "#{@task.title} 新增成功!" }
        format.turbo_stream
      else
        format.html { render :new }
        format.turbo_stream
      end
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: "#{@task.title} 更新成功!" }
      else
        render :edit
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_path, notice: "#{@task.title} 刪除成功!" }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@task)) }
      # 記得 include ActionView::RecordIdentifier
    end
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