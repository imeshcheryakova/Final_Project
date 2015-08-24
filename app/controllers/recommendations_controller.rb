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

    #Calculate Daily Calories Intake

    @DailyIntake = @current_user.weight*11*@current_user.activity_factor+100*@current_user.alcohol

    #Calculate Target Weight Loss/Gain

    @TargetLossGain = @current_user.target_pounds*3500/@current_user.target_days

    #Calculate Daily Target Calories

    @TargetCalories = @DailyIntake + @TargetLossGain

    if @current_user.body="Ectomorth"
      @TargetCalories=@TargetCalories*0.8
    end

    if @current_user.body="Mesomorth"
      @TargetCalories=@TargetCalories*1.0
    end

    if @current_user.body="Endomorth"
      @TargetCalories=@TargetCalories*1.2
    end

    #Calculate user input
    @MaxId= Users_input.where(user_id: @current_user.id).maximum(:created_at).id
    @UserInput = Users_input.find(@MaxId)
    @UserInput.exercise.calories_per_hour
    @UserInput.exercise_time

    @UserInputCalculated=@UserInput.exercise.calories_per_hour* @UserInput.exercise_time/60

    #Calories to Burn
    @CaloriestoBurn=@UserInputCalculated-@TargetCalories

    #if Input>Target => Excess Calories. Excess Calories + Target Calories*0.3 is the target number to burn via Exercise.
    #TargetCalories*0.3 is the final value for new meal.

    #if Input<Target => Lack of Calories. Lack Calories + Target Calories*0.3 is the final number for new meal.
    # TargetCalories*0.3 is the final value for exercise.

    #Calculating Final Calories Value for Recommendation

    if @CaloriestoBurn>0
      @CaloriestoExercise=@CaloriestoBurn+@TargetCalories*0.3
      @CaloriestoEat=@TargetCalories*0.3
    end

    if @CaloriestoBurn<0
      @CaloriestoExercise=@TargetCalories*0.3
      @CaloriestoEat=@CaloriestoBurn+@TargetCalories*0.3
    end

    if @CaloriestoBurn=0
      @CaloriestoExercise=@TargetCalories*0.3
      @CaloriestoEat=@TargetCalories*0.3
    end

    #Retrieveing Meals and Exercises for Recommendation


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
