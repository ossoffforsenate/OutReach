class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  layout 'big_jon'

  def new
  end

  def create
    @user = User.find_by(phone_number: "1234567890"))
    if @user
      session[:user_id] = @user.id
      session[:is_verifying] = false
      redirect_to root_url
    else
      flash[:danger] = 'No user found with the phone number provided. Try re-entering'
      redirect_to '/login'
    end
  end
end
