class Admin::UsersController < Admin::AdminController
  before_action :require_user_logged_in!
  before_action :check_admin
  before_action :set_user, only: %i[show edit update destroy]
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "#{@user.email} 創建成功!"
    else
      render :new
    end
  end

  def show
    @tasks = if params[:task] && !search_params[:keyword]
               @user.tasks.where(search_params).order(created_at: :desc).page(params[:page]).per(5)
             elsif params[:task] && search_params[:keyword]
               @user.tasks.where('title like ? or priority = ? and state = ?', "%#{search_params[:keyword]}%", Task.priorities[search_params[:priority]], Task.states[search_params[:state]])
                    .order(created_at: :desc).page(params[:page]).per(5)
             else
               @user.tasks.order(created_at: :desc).page(params[:page]).per(5)
             end

    if params[:sort].present?
      @tasks = Current.user.tasks.order("#{params[:sort]}").page(params[:page]).per(5)
    end

  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "#{@user.email} 更新成功!"
    else
      render :new
    end
  end

  def destroy
    admin_size = User.where(role: 'admin')
    if admin_size.size == 1 # 至少要剩一個管理員
      if @user.admin? # 一班使用者可以刪
        redirect_to admin_users_path, alert: "無法刪除使用者，請新增其他管理者"
      else
        @user.destroy
        redirect_to admin_users_path, notice: "#{@user.email} 刪除成功!"
      end
    else 
      @user.destroy
      redirect_to admin_users_path, notice: "#{@user.email} 刪除成功!"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :role)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def search_params
    params.require(:task).permit(:state, :priority, :title).reject{|key, val| val.blank?}
  end
end