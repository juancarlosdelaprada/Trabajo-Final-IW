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
      flash[:success] = "Logged in successfully"
      redirect_to books_path
    else 
      flash[:danger] = "Logged in unsuccesfully"
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    flash[:success] = "You have been Logged out"
    redirect_to login_path
  end
end