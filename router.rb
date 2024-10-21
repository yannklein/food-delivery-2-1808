class Router
  def initialize(meals_controller, customers_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @running = true
  end

  def run
    while @running
      print_menu
      choice = gets.chomp.to_i
      print `clear`
      route_action(choice)
    end
  end

  private

  def print_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. List all meals"
    puts "2. Add a new meal"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "8. Exit"
    print "> "
  end

  def route_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list

    when 8 then stop!
    else puts "Try again..."
    end
  end

  def stop!
    @running = false
  end
end