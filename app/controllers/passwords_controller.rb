class PasswordsController < ApplicationController
  before_action :require_user_logged_in! # 定義在父層方法, 檢查登入狀態

  def edit
  end

  def update
    if Current.user.update(password_params)
      redirect_to root_path, notice: '密碼更新成功! 下次登入請用新密碼'
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end