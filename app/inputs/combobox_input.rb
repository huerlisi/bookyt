class ComboboxInput < Formtastic::Inputs::SelectInput
  include ActionView::Helpers::UrlHelper

  def input_html_options
    super.merge({:class => "#{super[:class]} combobox", :style => "width => 60%"})
  end

  def link_fragment
    template.content_tag('span', template.link_to('show', @object.send(reflection.name), :class => 'icon-combolink-text'), :class => 'combobox-link')
  end

  def to_html
    input_wrapping do
      label_html <<
      (options[:group_by] ? grouped_select_html : select_html) <<
      link_fragment.html_safe
    end
  end
end
