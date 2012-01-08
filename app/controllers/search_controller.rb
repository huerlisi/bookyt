class SearchController < ApplicationController
  def search
    # TODO: get "undefined method `sphinx_index_options'" when Person and any other class is given???
    @people = ThinkingSphinx.search(params[:query], :classes => [Person])
    @invoices = ThinkingSphinx.search(params[:query], :classes => [Invoice])
  end
end
