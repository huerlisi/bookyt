class SalariesController < AuthorizedController
  # States
  has_scope :by_state

  # Actions
  def new
    # Allow pre-seeding some parameters
    salary_params = {
      :customer_id => current_tenant.company.id,
      :state       => 'booked',
      :value_date  => Date.today,
      :due_date    => Date.today.in(30.days).to_date
    }

    # Set default parameters
    salary_params.merge!(params[:salary]) if params[:salary]

    @salary = Salary.new(salary_params)
    
    # Prebuild an empty attachment instance
    @salary.attachments.build
    
    new!
  end

  def create
    @salary = Salary.new(params[:salary])
    @salary.build_booking
    
    create!
  end
end
