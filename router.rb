class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
    @current_user = nil
  end

  def run
    while @running
      @current_user = @sessions_controller.login
      while @current_user
        if @current_user.rider? 
          route_rider_action
        else
          route_manager_action
        end
      end
    end
  end

  # def run
  #   while @running
  #     @current_user = @sessions_controller.login if @current_user.nil?
  #     if @current_user.rider? 
  #       route_rider_action
  #     else
  #       route_manager_action
  #     end
  #   end
  # end

  private

  def route_rider_action
    print_rider_menu
    choice = gets.chomp.to_i
    print `clear`
    rider_action(choice)
  end

  def route_manager_action
    print_manager_menu
    choice = gets.chomp.to_i
    print `clear`
    manager_action(choice)
  end

  def print_rider_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. List all meals"
    puts "2. Add a new meal"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "5. Mark an order as delivered"
    puts "7. Log out"
    puts "8. Exit"
    print "> "
  end

  def print_manager_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. List all meals"
    puts "2. Add a new meal"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "5. Add new order"
    puts "6. List all undelivered orders"
    puts "7. Log out"
    puts "8. Exit"
    print "> "
  end

  def rider_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.mark_as_delivered(@current_user)
    when 7 then @current_user = nil
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 7 then @current_user = nil
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def stop!
    @current_user = nil
    @running = false
  end
end