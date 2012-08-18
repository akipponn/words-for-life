class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def login_required
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      redirect_to root_path
    end

  end

  def random_string
    temp = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    return Array.new(16){temp[rand(temp.size)]}.join
  end

  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
