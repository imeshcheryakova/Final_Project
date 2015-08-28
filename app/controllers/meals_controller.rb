require 'csv'
class MealsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :show]
  def index
    @meals = Meal.all
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new

    @meal.content = params[:content]
    @meal.serving_size = params[:serving_size]
    @meal.calories_per_portion = params[:calories_per_portion]
    @meal.meal = params[:meal]


    if @meal.save
      redirect_to "/meals", :notice => "Meal created successfully."
    else
      render 'new'
    end
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def update
    @meal = Meal.find(params[:id])

    @meal.content = params[:content]
    @meal.serving_size = params[:serving_size]
    @meal.calories_per_portion = params[:calories_per_portion]
    @meal.meal = params[:meal]

    if @meal.save
      redirect_to "/meals", :notice => "Meal updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @meal = Meal.find(params[:id])

    @meal.destroy

    redirect_to "/meals", :notice => "Meal deleted."
  end

  def readmeals
    Meal.delete_all
    csv_text = File.read('/Users/irina_m/Desktop/Meals.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Meal.create!(row.to_hash)

    end
    redirect_to "/meals"
  end

end
