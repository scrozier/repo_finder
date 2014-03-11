class MainController < ApplicationController

  protect_from_forgery :except => :developer_callback

  def welcome
  end

  def developer_callback
    session[:oauth_token] = 'be547aee16949447aae86c3bea4e6a4fae8ac2d4'
    render 'search'
  end

  def github_callback
    session[:oauth_token] = env['omniauth.auth']['credentials']['token']
    render 'search'
  end

  def repo_list
    github = Github.new oauth_token: session[:oauth_token]
    @result = github.search.repos('books')
  end

end