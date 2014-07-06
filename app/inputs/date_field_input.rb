class DateFieldInput < SimpleForm::Inputs::StringInput
  # Normalizes to localized date
  def date_value
    return unless object

    value = object.send(attribute_name)

    return nil unless value.present?

    value = Date.parse(value) if value.is_a? String

    I18n.localize(value)
  end

  def input
    input_html_options[:type] = 'text'
    template.content_tag(:div, :class => 'input-append date-picker date') do
      @builder.text_field(attribute_name, input_html_options.merge(:value => date_value)) +
        template.content_tag(:div, :class => 'add-on') do
          template.content_tag(:i, '', :class => 'icon-calendar')
        end
    end
  end
end
