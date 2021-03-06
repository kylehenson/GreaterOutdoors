class SessionsController < ApplicationController

  def create
    user = User.find_or_create_from_auth(auth)
    session[:user_id] = user.id
    session[:token] = auth.credentials.token
    session[:refresh_token] = auth.credentials.refresh_token
    redirect_to root_path
  end

  def destroy
    session.clear

    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
