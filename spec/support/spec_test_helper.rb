module SpecTestHelper   
  def login(user)
    user = User.where(email: user.email).first
    request.session[:user_id] = user.id
  end

  def current_user
    User.find(request.session[:user_id])
  end
end