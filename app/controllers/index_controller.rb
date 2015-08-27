class IndexController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:show]
  def show
@Name=current_user.first_name
  end

 end