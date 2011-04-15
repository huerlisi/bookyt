class SalariesController < AuthorizedController
  # States
  has_scope :by_state

  # Actions
  def new
    # Allow pre-seeding some parameters
    salary_params = {
      :customer_id    => current_tenant.company.id,
      :state          => 'booked',
      :duration_from  => Date.today,
      :duration_to    => Date.today.in(30.days).to_date
    }

    # Set default parameters
    salary_params.merge!(params[:salary]) if params[:salary]

    @salary = Salary.new(salary_params)
    
    # Prebuild an empty attachment instance
    @salary.attachments.build
    
    new!
  end

  def create
    # Calculate value and due dates
    date = Date.parse(params[:salary][:duration_from])
    value_date = Date.new(date.year, date.month, 1).in(1.month).ago(1.day)
    
    params[:salary][:value_date] = value_date
    params[:salary][:due_date] = value_date

    @salary = Salary.new(params[:salary])

    # TODO: workaround for reference lookup in booking templating
    @salary.save

    @salary.build_booking
    @salary.save
    
    create!
  end
end
