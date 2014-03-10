class MainController < ApplicationController

  protect_from_forgery except: :developer_callback

  def welcome
  end

  def developer_callback
    @params = params
  end

end