class SearchController < ApplicationController
  def search
    # TODO: get "undefined method `sphinx_index_options'" when Person and any other class is given???
    @records = ThinkingSphinx.search(params[:query], :classes => [Invoice, Company, Customer, Employee, Bank])
  end
end
