class MainController < ApplicationController

  protect_from_forgery except: :developer_callback

  def welcome
  end

  def developer_callback
    @params = params
  end

  def github_callback
    omni = env['omniauth.auth']
    @oauth_token = omni['credentials']['token']
  end

end