class TopController < ApplicationController
  def main
    if session[:login_uid].nil?
      render "login"
    else
      render "main"
    end
  end

  def login
    uid = params[:uid]
    pass = params[:pass]

    user = User.find_by(uid: uid)

    if user&.authenticate(pass)
      session[:login_uid] = user.uid
      redirect_to top_main_path
    else
    
      render "error", status: 422
    end
  end

  def logout
    session.delete(:login_uid)
    redirect_to top_main_path
  end
end