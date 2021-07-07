class ApplicationController < ActionController::Base
  before_action :set_current_user
  
  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_user_logged_in!
    redirect_to user_sign_in_path, alert: '請登入再繼續下面操作' if Current.user.nil?
  end
end
