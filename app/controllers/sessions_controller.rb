class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def menu
    if session["fb_access_token"].present?
      graph = Koala::Facebook::GraphAPI.new(session["fb_access_token"]) # Note that i'm using session here
      @profile_image = graph.get_picture("me")
      @fbprofile = graph.get_object("me")
      @friends = graph.get_connections("me", "friends")
      @friendsnumber = graph.get_connections("me", "friends").size
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end