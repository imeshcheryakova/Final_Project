class IndexController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:show]
  def index
  end

 end