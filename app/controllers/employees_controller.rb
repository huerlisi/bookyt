class EmployeesController < PeopleController
  defaults :resource_class => Employee

  def new
    @employee = Employee.new(params[:employee])

    @employee.build_vcard

    # Prebuild an employment
    @employee.employments.build(
      :employer => current_tenant.company
    )
  end

  def edit
    if resource.employments.empty?
      resource.employments.build(
        :employer => current_tenant.company
      )
    end

    edit!
  end
end
