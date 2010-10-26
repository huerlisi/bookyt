SimpleNavigation::Renderer::List.class_eval do
  alias old_render render
  def render(item_container)
    old_render(clean_up_html_options(item_container))
  end

  private
  #
  # Cleans the items from unused and not conform html_options
  #
  def clean_up_html_options(item_container)
   item_container.items.each do |item|
      html_options = item.html_options
      html_options.delete(:tooltip)
      item.html_options = html_options
   end

   item_container
  end
end