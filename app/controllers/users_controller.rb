class UsersController < ApplicationController
  before_action :require_user_logged_in! # 定義在父層方法, 檢查登入狀態
  before_action :find_user_and_profile

  def edit; end

  def update
    if Current.user.update(user_params)
      redirect_to root_path, notice: '更新成功!'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, profile_attributes: [:id, :phone, :address, :bio])
  end

  def find_user_and_profile
    @user = Current.user
    @profile = @user.profile || @user.create_profile
  end
end