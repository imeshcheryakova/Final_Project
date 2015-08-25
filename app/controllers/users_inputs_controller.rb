class UsersInputsController < ApplicationController

  before_action :authenticate_user!

  def index
    @users_inputs = UsersInput.all
  end

  def show
    @users_input = UsersInput.find(params[:id])
  end

  def new
    @users_input = UsersInput.new
  end

  def create
    @users_input = UsersInput.new
    @users_input.exercise_time = params[:exercise_time]
    @users_input.exercise_id = params[:exercise_id]
    @users_input.meal_id = params[:meal_id]
    @users_input.user_id = current_user.id

    if @users_input.save
      redirect_to "/create_recommendation"
    else
      render 'new'
    end
  end

  def edit
    @users_input = UsersInput.find(params[:id])
  end

  def update
    @users_input = UsersInput.find(params[:id])

    @users_input.exercise_time = params[:exercise_time]
    @users_input.exercise_id = params[:exercise_id]
    @users_input.meal_id = params[:meal_id]
    @users_input.user_id = params[:user_id]

    if @users_input.save
      redirect_to "/users_inputs", :notice => "Users input updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @users_input = UsersInput.find(params[:id])

    @users_input.destroy

    redirect_to "/users_inputs", :notice => "Users input deleted."
  end
end
