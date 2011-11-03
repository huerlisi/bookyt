class LineItemsController < AuthorizedController
  belongs_to :debit_invoice

  def new
    @invoice = parent
    @line_item = @invoice.line_items.build
  end
end
