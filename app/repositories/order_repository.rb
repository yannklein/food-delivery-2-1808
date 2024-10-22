require 'csv'
require_relative '../models/order'
class OrderRepository
  def initialize(csv_path, meal_repo, customer_repo, employee_repo)
    @csv_path = csv_path
    @orders = []
    @meal_repo = meal_repo
    @customer_repo = customer_repo
    @employee_repo = employee_repo
    @next_id = 1
    load_csv if File.exists?(@csv_path)
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def my_undelivered_orders(employee)
    @orders.select { |order| !order.delivered? && order.employee == employee }
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  def create(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  def all
    @orders
  end

  private 

  def load_csv
    CSV.foreach(@csv_path, headers: :first_row, header_converters: :symbol) do |row|
      # row --> { id: "1", delivered: "true", meal_id: "1",...}
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == "true"

      row[:meal_id] = row[:meal_id].to_i
      row[:customer_id] = row[:customer_id].to_i
      row[:employee_id] = row[:employee_id].to_i

      row[:meal] = @meal_repo.find(row[:meal_id])
      row[:customer] = @customer_repo.find(row[:customer_id])
      row[:employee] = @employee_repo.find(row[:employee_id])
      # row --> { id: 1, delivered: false, meal_id: "1", meal: <Meal#XX03>}
      
      @orders << Order.new(row)
      # @next_id += 1
    end
    @next_id = @orders.last.id + 1 unless @orders.empty?
  end

  def save_csv
    CSV.open(@csv_path, 'wb') do |csv|
      csv << ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id']
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end
end