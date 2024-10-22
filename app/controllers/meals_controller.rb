require_relative "../views/meals_view"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meal_view = MealsView.new
  end

  def list
    # get the meals from the repository
    meals = @meal_repository.all
    # give the meals to the view to display them
    @meal_view.display(meals)
  end

  def add
    # ask the user for the meal name and store it
    name = @meal_view.ask_for("name")
    # ask the user for the meal price and store it
    price = @meal_view.ask_for("price").to_i
    # create a new meal instance
    meal = Meal.new(name: name, price: price)
    # ask the repository to store the instance
    @meal_repository.create(meal)
  end
end
