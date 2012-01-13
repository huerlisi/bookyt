# Renders an ItemContainer as a <ul> element and its containing items as <li> elements.
# Prepared to use inside the topbar of Twitter Bootstrap http://twitter.github.com/bootstrap/#navigation
#
# Register the renderer and use following code in your view:
#   render_navigation(level: 1..2, renderer: :bootstrap_topbar_list, expand_all: true)
class BootstrapTopbarList < SimpleNavigation::Renderer::Base

  def render(item_container)
    if options[:is_subnavigation]
      ul_class = "dropdown-menu"
    else
      ul_class = "nav"
    end

    list_content = item_container.items.inject([]) do |list, item|
      li_options = item.html_options.reject {|k, v| k == :link}
      if include_sub_navigation?(item)
        li_options[:class] = [li_options[:class], "dropdown"].flatten.compact.join(' ')
      end
      li_content = tag_for(item)
      if include_sub_navigation?(item)
        li_content << render_sub_navigation_for(item)
      end
      list << content_tag(:li, li_content, li_options)
    end.join
    if skip_if_empty? && item_container.empty?
      ''
    else
      content_tag(:ul, list_content, { :id => item_container.dom_id, :class => [item_container.dom_class, ul_class].flatten.compact.join(' '), 'data-dropdown' => 'dropdown' })
    end
  end

  def render_sub_navigation_for(item)
    item.sub_navigation.render(self.options.merge(:is_subnavigation => true))
  end

  protected

  def tag_for(item)
    if item.url.nil?
      content_tag('span', item.name, link_options_for(item).except(:method))
    else
      link_to(item.name, item.url, link_options_for(item))
    end
  end

  # Extracts the options relevant for the generated link
  #
  def link_options_for(item)
    special_options = {:method => item.method}.reject {|k, v| v.nil? }
    link_options = item.html_options[:link] || {}
    opts = special_options.merge(link_options)
    opts[:class] = [link_options[:class], item.selected_class, dropdown_link_class(item)].flatten.compact.join(' ')
    opts.delete(:class) if opts[:class].nil? || opts[:class] == ''
    opts
  end

  def dropdown_link_class(item)
    if include_sub_navigation?(item) && !options[:is_subnavigation]
      "dropdown-toggle"
    end
  end
end
