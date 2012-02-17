class ComboboxInput < FormtasticBootstrap::Inputs::SelectInput
  include ActionView::Helpers::UrlHelper

  def input_html_options
    super.merge({:class => "#{super[:class]} combobox", :style => "width => 60%"})
  end

  def link_fragment
    reference = object.send(reflection.name)

    if reference
      template.content_tag('span', template.link_to('show', @object.send(reflection.name), :class => 'icon-combolink-text'), :class => 'combobox-link')
    else
      url_method = "new_#{reflection.name}_#{object.class.model_name.underscore.pluralize}_url"
      if template.respond_to?(url_method)
        template.content_tag('span', template.link_to('new', template.send(url_method), :remote => true, :class => 'icon-add-text'), :class => "combobox-link new_#{reflection.name}")
      end
    end
  end

  def to_html
    generic_input_wrapping do
      (options[:group_by] ? grouped_select_html : select_html) <<
      link_fragment
    end
  end
end
