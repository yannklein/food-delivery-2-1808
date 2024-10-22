class OrdersView
  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1}. [#{order.delivered? ? "X" : " "}] #{order.meal.name} - #{order.customer.name} | #{order.employee.username}"
    end
  end

  def ask_for(thing)
    puts "What's the #{thing}?"
    gets.chomp
  end
end
