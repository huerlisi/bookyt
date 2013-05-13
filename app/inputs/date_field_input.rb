class DateFieldInput < SimpleForm::Inputs::StringInput
  def input
    input_html_options['date-picker'] = true
    input_html_options[:type] = 'text'
    super
  end
end
