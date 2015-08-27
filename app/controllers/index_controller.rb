class IndexController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:show]
  def show
    if user_signed_in?
@Name=current_user.first_name
  end
end
 end