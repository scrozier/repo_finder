class MainController < ApplicationController

  protect_from_forgery :except => :developer_callback

  def welcome
  end

  def developer_callback
    session[:oauth_token] = 'a14ce94def68a901630f77dbd5468f7fe7efb9de'
    render 'search'
  end

  def github_callback
    session[:oauth_token] = env['omniauth.auth']['credentials']['token']
    render 'search'
  end

  def repo_list
    github = Github.new oauth_token: session[:oauth_token]
    result = github.search.repos('books')
    @total_count = result['total_count']
    @items = result['items']
  end

end