class SessionsController < ApplicationController
  
  def create  
    # raise request.env["omniauth.auth"].to_yaml 
    
    auth = request.env["omniauth.auth"]  
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)  
    session[:user_id] = user.id  
    session[:prof_image] = auth.info.image
    if auth.provider == "facebook"
      session[:provider] = "facebook"
      session[:prof_url] = auth.info.urls.Facebook
    elsif auth.provider == "twitter"
      session[:provider] = "twitter"
      session[:prof_url] = auth.info.urls.Twitter      
    end
    redirect_to :my_messages, :notice => "Signed in!"
  end  
  
  def destroy
    session[:user_id] = nil
    session[:provider] = nil
    session[:prof_image] = nil
    session[:prof_url] = nil
    redirect_to root_path
  end
end
