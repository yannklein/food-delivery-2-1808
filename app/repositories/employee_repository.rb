require 'csv'
require_relative '../models/employee'
class EmployeeRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @employees = []
    load_csv
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def all_riders
    @employees.select { |employee| employee.rider? }
  end

  private

  def load_csv
    CSV.foreach(@csv_path, headers: :first_row, header_converters: :symbol ) do |row|
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
  end
end