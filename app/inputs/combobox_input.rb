class ComboboxInput < SimpleForm::Inputs::StringInput
  def input
    input_html_options['date-picker'] = true
    super
  end
end