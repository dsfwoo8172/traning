class Admin::AdminController < ApplicationController
  def check_admin
    redirect_to root_path, alert: "#{Current.user.email} 權限不足，請洽管理員" if !Current.user.admin?
  end
end