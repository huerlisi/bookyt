class SearchController < ApplicationController
  def search
    # TODO: Implement pagination
    @people = Person.by_text(params[:query])
    @invoices = Invoice.by_text(params[:query])
  end
end
