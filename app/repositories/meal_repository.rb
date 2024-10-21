require "csv"
require_relative "../models/meal"

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = [] # array of instances of meal
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def create(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      # p attributes
      # #<CSV::Row id:"1" name:"spaghetti" price:"800">
      # convert any strings to the actual data we want
      # id = attributes[:id].to_i
      # name = attributes[:name]
      # price = attributes[:price].to_i
      attributes[:id] = attributes[:id].to_i
      attributes[:price] = attributes[:price].to_i
      # p attributes
      # create a meal instance
      # push the instance into the @meals array
      @meals << Meal.new(attributes)
      # Meal.new(id: id, name: name, price: price)
    end
    @next_id = @meals.last.id + 1 unless @meals.empty?
  end

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << %w(id, name, price)
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end
