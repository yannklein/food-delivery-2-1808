require "csv"
require_relative "../models/meal"

class CustomerRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = [] # array of instances of customer
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @customers
  end

  def create(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      # p attributes
      # #<CSV::Row id:"1" name:"spaghetti" address:"800">
      # convert any strings to the actual data we want
      # id = attributes[:id].to_i
      # name = attributes[:name]
      attributes[:id] = attributes[:id].to_i
      # p attributes
      # create a customer instance
      # push the instance into the @customers array
      @customers << Customer.new(attributes)
      # customer.new(id: id, name: name, address: address)
    end
    @next_id = @customers.last.id + 1 unless @customers.empty?
  end

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << %w(id, name, address)
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end
