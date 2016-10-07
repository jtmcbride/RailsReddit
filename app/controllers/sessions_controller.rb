class SessionsController < ApplicationController
  
  def new
  end

  def create
    @user = User.find_by_creds(session_params[:username], session_params[:password])
    if @user
      login(@user)
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
      redirect_to new_session_url
    else
      redirect_to new_session_url
    end
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
