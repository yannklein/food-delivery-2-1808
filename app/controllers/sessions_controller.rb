require_relative '../views/sessions_view'
class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    # Ask for username
    username = @sessions_view.ask_for(:username)
    # Ask for password
    password = @sessions_view.ask_for(:password)
    # Check if exist/correct
    employee = @employee_repository.find_by_username(username)
    #   if yes, return the user (instance of employee)
    return employee if employee && employee.password == password
    #   if not, displays 'error' and makes you try again
    @sessions_view.wrong_password
    login
  end
end