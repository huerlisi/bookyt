class EmploymentsController < AuthorizedController
  has_scope :by_employee
end
