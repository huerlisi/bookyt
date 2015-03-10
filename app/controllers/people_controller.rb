class PeopleController < AuthorizedController
  has_scope :by_text

  def show
    # Invoice scoping by state
    @invoices = resource.invoices.where("type != 'Salary'").invoice_state(params[:invoice_state])

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
