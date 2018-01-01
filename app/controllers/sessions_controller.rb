class SessionsController < ApplicationController
  skip_before_action :ensure_login, only: [:new, :create]
  
  def new
    # mostrar vista sessions/new (/login)
  end

  def create
    reviewer = Reviewer.find_by(name: params[:reviewer][:name])
    password = params[:reviewer][:password]
    if reviewer && reviewer.authenticate(password)
      session[:reviewer_id] = reviewer.id
      redirect_to root_path, notice: "Logged in successfully"
    else 
      redirect_to login_path, alert: "Logged in unsuccesfully"
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "You have been Logged out"
  end
end