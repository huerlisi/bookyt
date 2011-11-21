class EmployeesController < PeopleController
  defaults :resource_class => Employee

  def new
    @employee = Employee.new(params[:employee])

    @employee.employments.build(
      :employer => current_tenant.company
    )
  end
end
