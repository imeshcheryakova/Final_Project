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

    #Retrieve last data row from DB

    #Run calculation
    #1.Calculate difference between user's food and exercise
    #2.Determine coefficients based on body type and alcohol consumption
    #3.Adjust calories from step 1
    #4.Adjust by daily calories intake
    #5.Check whether 4. negative or positive
    #6.Suggest Preselected exercise to burn 70%
    #7.Suggest list of meals with calories less or equeal 30% of step 4

=begin
    @recommendation.recommendation_meal_portions = params[:recommendation_meal_portions]
    @recommendation.recommendation_time_exercise = params[:recommendation_time_exercise]
    @recommendation.exercise_id = params[:exercise_id]
    @recommendation.meal_id = params[:meal_id]
    @recommendation.user_id = params[:user_id]
=end

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
