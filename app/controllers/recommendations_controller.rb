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


    #Calculate user input
    @MaxId= UsersInput.where(user_id: current_user.id).maximum(:id)
    @UserInput = UsersInput.find(@MaxId)

    @UserInputCalculated=@UserInput.exercise.calories_per_hour*(-1)* @UserInput.exercise_time/60

      #Calculate Daily Calories Intake

    @DailyIntake = current_user.weight*11*current_user.activity_factor+100*current_user.alcohol/7+@UserInput.meal.calories_per_portion

    #Calculate Target Weight Loss/Gain

    @TargetLossGain = current_user.target_pounds*3500/current_user.target_days

    #Calculate Daily Target Calories

    @TargetCalories = @DailyIntake + @TargetLossGain

    if current_user.body=="Ectomorth"
      @TargetCalories=@TargetCalories*0.8
    end

    if current_user.body=="Mesomorth"
      @TargetCalories=@TargetCalories*1.0
    end

    if current_user.body=="Endomorth"
      @TargetCalories=@TargetCalories*1.2
    end


    #Calories Needed
    if @DailyIntake>0
    @CaloriesNeeded=@TargetCalories-@UserInputCalculated
    end
    if @DailyIntake<0
      @CaloriesNeeded=@TargetCalories+@UserInputCalculated
    end
    if @DailyIntake==0
      @CaloriesNeeded=@TargetCalories
    end


    #if Input>Target => Excess Calories. Excess Calories + Target Calories*0.3 is the target number to burn via Exercise.
    #TargetCalories*0.3 is the final value for new meal.

    #if Input<Target => Lack of Calories. Lack Calories + Target Calories*0.3 is the final number for new meal.
    # TargetCalories*0.3 is the final value for exercise.

    #Calculating Final Calories Value for Recommendation

    if @CaloriesNeeded>0
      @CaloriestoExercise=250.0
      @CaloriestoEat=@CaloriesNeeded+250
    end

    if @CaloriesNeeded<0
      @CaloriestoExercise=@CaloriesNeeded*(-1)+150
      @CaloriestoEat=150
    end

    if @CaloriesNeeded==0
      @CaloriestoExercise=250.0
      @CaloriestoEat=250.0
    end


    #Retrieveing Meals and Exercises for Recommendation
    @MyExercise = Exercise.where("calories_per_hour<? AND calories_per_hour>?", @CaloriestoExercise, @CaloriestoExercise/2).take!
    @MyMeal = Meal.where("calories_per_portion>? AND calories_per_portion<?", @CaloriestoEat/10, @CaloriestoEat).take!


    @recommendation.recommended_exercise_time = @MyExercise.calories_per_hour/@CaloriestoExercise*60
    @recommendation.exercise_id=@MyExercise.id
    @recommendation.meal_id=@MyMeal.id
    @recommendation.user_id=current_user.id

    if @recommendation.save
      redirect_to "/recommendations", :notice => "Recommendation created successfully."
    else
      render 'recommendation_debug'
    end


  end

  def create_old
    @recommendation = Recommendation.new

    #Calculate Daily Calories Intake

    @DailyIntake = current_user.weight*11*current_user.activity_factor+100*current_user.alcohol

    #Calculate Target Weight Loss/Gain

    @TargetLossGain = current_user.target_pounds*3500/current_user.target_days

    #Calculate Daily Target Calories

    @TargetCalories = @DailyIntake + @TargetLossGain

    if current_user.body="Ectomorth"
      @TargetCalories=@TargetCalories*0.8
    end

    if current_user.body="Mesomorth"
      @TargetCalories=@TargetCalories*1.0
    end

    if current_user.body="Endomorth"
      @TargetCalories=@TargetCalories*1.2
    end

    #Calculate user input
    @MaxId= UsersInput.where(user_id: current_user.id).maximum(:id)
    @UserInput = UsersInput.find(@MaxId)

    @UserInputCalculated=@UserInput.exercise.calories_per_hour* @UserInput.exercise_time/60

    #Calories to Burn
    @CaloriesNeeded=@UserInputCalculated-@TargetCalories

    #if Input>Target => Excess Calories. Excess Calories + Target Calories*0.3 is the target number to burn via Exercise.
    #TargetCalories*0.3 is the final value for new meal.

    #if Input<Target => Lack of Calories. Lack Calories + Target Calories*0.3 is the final number for new meal.
    # TargetCalories*0.3 is the final value for exercise.

    #Calculating Final Calories Value for Recommendation

    if @CaloriesNeeded>0
      @CaloriestoExercise=@CaloriesNeeded+@TargetCalories*0.3
      @CaloriestoEat=@TargetCalories*0.3
    end

    if @CaloriesNeeded<0
      @CaloriestoExercise=@TargetCalories*0.3
      @CaloriestoEat=@CaloriesNeeded+@TargetCalories*0.3
    end

    if @CaloriesNeeded=0
      @CaloriestoExercise=@TargetCalories*0.3
      @CaloriestoEat=@TargetCalories*0.3
    end

    #Retrieveing Meals and Exercises for Recommendation
    @MyExercise = Exercise.where("calories_per_hour>? AND calories_per_hour*2<?", @CaloriestoExercise, @CaloriestoExercise).take!
    @MyMeal = Meal.where("calories_per_portion*0.8>? AND calories_per_portion*1.2<?", @CaloriestoEat, @CaloriestoEat).take!


    @recommendation.recommended_exercise_time = @MyExercise.calories_per_hour/@CaloriestoExercise*60
    @recommendation.exercise_id=@MyExercise.id
    @recommendation.meal_id=@MyMeal.id
    @recommendation.user_id=current_user.id

    if @recommendation.save
      redirect_to "/recommendations", :notice => "Recommendation created successfully."
    else
      render 'show'
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
