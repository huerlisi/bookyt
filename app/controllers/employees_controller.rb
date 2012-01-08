class EmployeesController < PeopleController
  defaults :resource_class => Employee

  def new
    @employee = Employee.new(params[:employee])

    @employee.build_vcard

    # Prebuild an employment
    @employee.employments.build(
      :duration_from => Date.today,
      :employer      => current_tenant.company
    )

    # We've got only the freshly created employment
    @employments = @employee.employments
    new!
  end

  def edit
    # Prebuild an employment if there's no valid one
    @employments = @employee.employments.valid
    if @employments.empty?
      new_employment = resource.employments.build(
        :duration_from => Date.today,
        :employer      => current_tenant.company
      )
      # Add new employment to be shown in form
      @employments = [new_employment]
    end

    edit!
  end
end
