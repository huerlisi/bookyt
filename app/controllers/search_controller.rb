class SearchController < ApplicationController
  def search
    # TODO: get "undefined method `sphinx_index_options'" when Person and any other class is given???
    # TODO: Implement pagination
    @people = ThinkingSphinx.search(params[:query], :classes => [Person], :star => true, :per_page => 100, :order => 'sort_name ASC')
    @invoices = ThinkingSphinx.search(params[:query], :classes => [Invoice], :star => true, :per_page => 100, :order => 'value_date DESC')
  end
end
