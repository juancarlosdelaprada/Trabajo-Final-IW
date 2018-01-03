class ReviewersController < ApplicationController
  skip_before_action :ensure_login, only: [:new, :create]
  
  def new
    @reviewer = Reviewer.new
  end
  
  def create
    @reviewer = Reviewer.new(reviewer_params)
    if verify_recaptcha(model: @reviewer) && @reviewer.save
      redirect_to books_path, notice: 'Reviewer was successfully created.' 
    else
      render :new 
    end
  end
  
  private
    def reviewer_params
      params.require(:reviewer).permit(:name, :password, :password_confirmation)
    end
end