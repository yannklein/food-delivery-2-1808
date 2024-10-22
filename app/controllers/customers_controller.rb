require_relative "../views/customers_view"
require_relative "../models/customer"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # get the customers from the repository
    customers = @customer_repository.all
    # give the customers to the view to display them
    @customers_view.display(customers)
  end

  def add
    # ask the user for the customer name and store it
    name = @customers_view.ask_for("name")
    # ask the user for the customer address and store it
    address = @customers_view.ask_for("address")
    # create a new customer instance
    customer = Customer.new(name: name, address: address)
    # ask the repository to store the instance
    @customer_repository.create(customer)
  end
end
