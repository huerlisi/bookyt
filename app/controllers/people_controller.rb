class PeopleController < AuthorizedController
  def index
    set_collection_ivar resource_class.search(
      params[:by_text],
      :star => true,
      :page => params[:page]
    )
  end

  def show
    @credit_invoices = resource.credit_invoices.reorder('due_date DESC')
    @debit_invoices = resource.debit_invoices.reorder('due_date DESC')

    # Invoice scoping by state
    invoice_state = params[:invoice_state]
    @credit_invoices = @credit_invoices.invoice_state(invoice_state)
    @debit_invoices = @debit_invoices.invoice_state(invoice_state)

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
