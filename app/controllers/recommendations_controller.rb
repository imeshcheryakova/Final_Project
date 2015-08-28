class RecommendationsController < ApplicationController
  def index
    @recommendations = current_user.recommendations.order(created_at: :desc)
  end

  def show
    @recommendation=Recommendation.where(user_id: current_user.id, id: params[:id] ).take!
  end

  def new
    @recommendation = Recommendation.new
  end

  def create
    @recommendation = Recommendation.new

  #RECOMMENDATION GENERATION

    #Calculate user input
    @MaxId= UsersInput.where(user_id: current_user.id).maximum(:id)
    @UserInput = UsersInput.find(@MaxId)

    @UserInputCalculated=@UserInput.exercise.calories_per_hour*(-1)* @UserInput.exercise_time/60+@UserInput.meal.calories_per_portion

    #Calculate Base Daily Calories Intake for this User (before gain/loss weight target)

    @DailyIntake = current_user.weight*11*current_user.activity_factor+100*current_user.alcohol/7

    #Calculate Daily Target Calories (1-lose weight, 2-gain weight, 3- no change)

    @TargetCalories=@DailyIntake
    if current_user.weight_target==1
      @TargetCalories=@DailyIntake-300
      end
    if current_user.weight_target==2
      @TargetCalories=@DailyIntake+300
    end
    if current_user.weight_target==3
      @TargetCalories=@DailyIntake+0
    end

    #Target Daily Calories Adjusted by Body Type

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
      @CaloriesNeeded=@TargetCalories-@UserInputCalculated

    #Calculating Final Calories Value for Recommendation

    if @CaloriesNeeded>0 and @CaloriesNeeded>@TargetCalories
      @CaloriestoExercise=@CaloriesNeeded-@TargetCalories+300.0
      @CaloriestoEat=300.0
    end

    if @CaloriesNeeded>0 and @CaloriesNeeded<@TargetCalories
      @CaloriestoExercise=300.0
      @CaloriestoEat=@TargetCalories-@CaloriesNeeded+300.0
    end

    if @CaloriesNeeded<0
      @CaloriestoExercise=300.0
      @CaloriestoEat=@TargetCalories+@CaloriesNeeded*(-1)+300.0
    end

    if @CaloriesNeeded==0
      @CaloriestoExercise=300.0
      @CaloriestoEat=300.0
    end

    #Retrieveing Meals and Exercises for Recommendation

    if current_user.favorites.count != 0
      @MyExercises=current_user.exercises
    else
      @MyExercises = Exercise.where("calories_per_hour<? AND calories_per_hour>?", @CaloriestoExercise, @CaloriestoExercise/4)

    end

    @MyMeals = Meal.where("calories_per_portion>? AND calories_per_portion<?", @CaloriestoEat/10, @CaloriestoEat)

    if not @MyMeals.present?
      raise "No matching meal: need between #{@CaloriestoEat/10} and #{@CaloriestoEat}"
    end
    if not @MyExercises.present?

      raise "No matching exercise: need between #{@CaloriestoExercise/2} and #{@CaloriestoExercise}"
    end
    #random matching exercise and meal
    @MyExercise = @MyExercises.sample
    @MyMeal = @MyMeals.sample

    @recommendation.recommended_exercise_time = @MyExercise.calories_per_hour/@CaloriestoExercise*60
    @recommendation.exercise_id=@MyExercise.id
    @recommendation.meal_id=@MyMeal.id
    @recommendation.user_id=current_user.id

    @recommendation.save

      render 'create_recommendation'



  end

  def edit
    @recommendation = Recommendation.find(params[:id])
  end

  def update
    @recommendation = Recommendation.find(params[:id])


    @recommendation.recommended_exercise_time = params[:recommended_exercise_time]
    @recommendation.exercise_id = params[:exercise_id]
    @recommendation.meal_id = params[:meal_id]
    @recommendation.user_id = current_user.id

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
