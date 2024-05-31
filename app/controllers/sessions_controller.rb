class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome."
        redirect_to "/places"
      else
        flash["notice"] = "Please check your email address or password and try again."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Please check your email address or password and try again."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Good bye!"
    redirect_to "/login"
  end
end