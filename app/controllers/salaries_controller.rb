class SalariesController < AuthorizedController
  # Filter/Search
  # =============
  has_scope :by_state
  has_scope :by_value_period, :using => [:from, :to], :default => proc { |c| c.session[:has_scope] }
  has_scope :by_employee_id

  # Actions
  # =======
  def statistics
    index!
  end

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
    @salary = Salary.new(params[:salary])
    @salary.build_booking

    create!
  end

  def payslip
    show!
  end
end
