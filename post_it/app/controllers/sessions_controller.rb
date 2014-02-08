class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true  #allows access to pin action
        user.generate_pin!
        user.send_pin_to_twilio
        redirect_to pin_path
      else
        login_user(user)
      end
    else
      flash.now[:error] = 'Invalid username or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out!"
    redirect_to root_path
  end

  def pin
    access_denied if session[:two_factor].nil? #stop access to page via URL input

    if request.post?
      user = User.find_by(:pin => params[:pin])
      if user
        session[:two_factor] = nil
        user.remove_pin
        login_user(user)
      else
        flash[:error] = 'Something is wrong with your pin'
        redirect_to root_path
      end
    end
  end

  private
    def login_user(user)
      session[:user_id] = user.id
      flash[:notice] = "Welcome, you've logged in"
      redirect_to root_path
    end
end