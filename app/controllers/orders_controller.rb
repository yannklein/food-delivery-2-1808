require_relative '../views/meals_view'
require_relative '../views/customers_view'
require_relative '../views/sessions_view'
require_relative '../views/orders_view'

class OrdersController
  def initialize(meal_repo, customer_repo, employee_repo, order_repo)
    @meal_repo = meal_repo
    @customer_repo = customer_repo
    @employee_repo = employee_repo
    @order_repo = order_repo

    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @sessions_view = SessionsView.new
    @orders_view = OrdersView.new
  end

  def add
    # Display all the meals
    meals = @meal_repo.all # array of meal instances
    # Ask the user to select a meal by index
    @meals_view.display(meals)
    # get the instance meal corresponding to the given index
    meal_index = @meals_view.ask_for(:index).to_i - 1
    meal = meals[meal_index]
    
    # Display all the customers
    customers = @customer_repo.all # array of customer instances
    # Ask the user to select a customer by index
    @customers_view.display(customers)
    # get the instance customer corresponding to the given index
    customer_index = @customers_view.ask_for(:index).to_i - 1
    customer = customers[customer_index]

    # Display all the riders
    employees = @employee_repo.all_riders # array of employee instances
    # Ask the user to select a employee by index
    @sessions_view.display(employees)
    # get the instance employee corresponding to the given index
    employee_index = @sessions_view.ask_for(:index).to_i - 1
    employee = employees[employee_index]

    # Make a new order!
    order = Order.new(
      meal: meal,
      customer: customer,
      employee: employee
    )
    # Store it in the CSV (repo)
    @order_repo.create(order)
  end

  def list_undelivered_orders
    # retrieve undelievered orders from the repo
    orders = @order_repo.undelivered_orders
    # display orders in thde view
    @orders_view.display(orders)
  end

  def mark_as_delivered(employee)
    # Retieve undelievered orders from the repo
    orders = @order_repo.my_undelivered_orders(employee)
    # Display orders
    @orders_view.display(orders)
    # Ask the user what index to mark as done
    index = @orders_view.ask_for(:order).to_i - 1
    # get the right order
    order = orders[index]
    # update to delivered
    @order_repo.mark_as_delivered(order)
  end
end