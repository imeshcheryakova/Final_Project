
require 'csv'
class ExercisesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :show]

  def index
    @exercises = Exercise.all
  end

  def show
    @exercise = Exercise.find(params[:id])
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new
    @exercise.weather = params[:weather]
    @exercise.calories_per_hour = params[:calories_per_hour]
    @exercise.exercise = params[:exercise]

    if @exercise.save
      redirect_to "/exercises", :notice => "Exercise created successfully."
    else
      render 'new'
    end

  end

  def edit
    @exercise = Exercise.find(params[:id])
  end

  def update
    @exercise = Exercise.find(params[:id])

    @exercise.weather = params[:weather]
    @exercise.calories_per_hour = params[:calories_per_hour]
    @exercise.exercise = params[:exercise]

    if @exercise.save
      redirect_to "/exercises", :notice => "Exercise updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @exercise = Exercise.find(params[:id])

    @exercise.destroy

    redirect_to "/exercises", :notice => "Exercise deleted."
  end

def readexercises
  Exercise.delete_all
  csv_text = File.read('/Users/irina_m/Desktop/exercises.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Exercise.create!(row.to_hash)

  end
  redirect_to "/exercises"
  end
end
