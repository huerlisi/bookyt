class HourFieldInput < Formtastic::Inputs::StringInput
  def input_html_options
    super.merge(:class => "#{super[:class]} hasCheckHours", :alt => 'time', 'data-check-hours' => true)
  end
end