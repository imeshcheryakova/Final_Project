class RecommendationsController < ApplicationController
  def index
    @recommendations = Recommendation.all
  end

  def show
    @recommendation = Recommendation.find(params[:id])
  end

  def new
    @recommendation = Recommendation.new
  end

  def create
    @recommendation = Recommendation.new
    @recommendation.recommendation_meal_portions = params[:recommendation_meal_portions]
    @recommendation.recommendation_time_exercise = params[:recommendation_time_exercise]
    @recommendation.exercise_id = params[:exercise_id]
    @recommendation.meal_id = params[:meal_id]
    @recommendation.user_id = params[:user_id]

    if @recommendation.save
      redirect_to "/recommendations", :notice => "Recommendation created successfully."
    else
      render 'new'
    end
  end

  def edit
    @recommendation = Recommendation.find(params[:id])
  end

  def update
    @recommendation = Recommendation.find(params[:id])

    @recommendation.recommendation_meal_portions = params[:recommendation_meal_portions]
    @recommendation.recommendation_time_exercise = params[:recommendation_time_exercise]
    @recommendation.exercise_id = params[:exercise_id]
    @recommendation.meal_id = params[:meal_id]
    @recommendation.user_id = params[:user_id]

    if @recommendation.save
      redirect_to "/recommendations", :notice => "Recommendation updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @recommendation = Recommendation.find(params[:id])

    @recommendation.destroy

    redirect_to "/recommendations", :notice => "Recommendation deleted."
  end
end
