class MainController < ApplicationController

  def welcome
  end

  def github_callback
    session[:oauth_token] = env['omniauth.auth']['credentials']['token']
    render 'search'
  end

end