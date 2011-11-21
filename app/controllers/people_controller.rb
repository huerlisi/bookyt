class PeopleController < AuthorizedController
  def index
    @people = Person.search(params[:by_text], :star => true, :page => params[:page])
  end

  def show
    @credit_invoices = resource.credit_invoices
    @debit_invoices = resource.debit_invoices

    # Invoice scoping by state
    by_state = params[:by_state] || 'all'
    @credit_invoices = @credit_invoices.reorder('due_date DESC').by_state(by_state)
    @debit_invoices = @debit_invoices.reorder('due_date DESC').by_state(by_state)

    show!
  end

  # has_many :phone_numbers
  def new_phone_number
    if resource_id = params[:id]
      @person = Person.find(resource_id)
    else
      @person = resource_class.new
    end

    @vcard = @person.vcard
    @item = @vcard.contacts.build

    respond_with @item
  end
end
