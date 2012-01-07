class DateFieldInput < FormtasticBootstrap::Inputs::StringInput
  def input_html_options
    super.merge("date-picker" => true)
  end
end
