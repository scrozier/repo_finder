class MainController < ApplicationController

  protect_from_forgery :except => :developer_callback

  def welcome
    if session[:oauth_token]
      set_up_no_query
      render :repo_list
      return
    end
  end

  def developer_callback
    session[:oauth_token] = 'a14ce94def68a901630f77dbd5468f7fe7efb9de'
    set_up_no_query
    render :repo_list
  end

  def github_callback
    session[:oauth_token] = env['omniauth.auth']['credentials']['token']
    set_up_no_query
    render :repo_list
  end

  def repo_list
    github = Github.new oauth_token: session[:oauth_token]
    @current_query = params[:keyword]
    unless @current_query.blank?
      @page = params[:page].to_i || 1
      @sort = params[:sort] || 'asc'
      result = github.search.repos(@current_query, page: @page, sort: 'stars', order: @sort)
      @total_count = result['total_count']
      @items = result['items']
      @languages = @items.collect{|r| r.language}.uniq
      @languages.delete nil
    else
      set_up_no_query
    end
  end

  private

  def set_up_no_query
    @total_count = 0
    @items = []
  end

end