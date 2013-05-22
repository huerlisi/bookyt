class DateFieldInput < SimpleForm::Inputs::StringInput
  def input
    input_html_options[:type] = 'text'
    template.content_tag(:div, :class => 'input-append date-picker date') do
      super +
        template.content_tag(:div, :class => 'add-on') do
          template.content_tag(:i, '', :class => 'icon-calendar')
        end
    end
  end
end
