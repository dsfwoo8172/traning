class SessionsController < ApplicationController

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password]) # authenticate 是 has_secure_password 提供驗證密碼的方法
      session[:user_id] = user.id # 將 id 當作是 token 代表使用者登入成功
      redirect_to root_path, notice: '登入成功!'
    else
      flash[:alert] = '信箱或密碼錯誤'
      render :new # 重新 render 登入表單
    end
  end

  def destroy
    session[:user_id] = nil # 清除 session
    redirect_to root_path, notice: "登出成功!"
  end
end