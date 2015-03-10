# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Plugins
  def engine_stylesheet_link_tag(options = {})
    Bookyt::Engine.engines.map {|engine|
      stylesheet_link_tag engine, options
    }.join.html_safe
  end

  # Sidebar Filters
  def define_filter(name, &block)
    @filters ||= {}
    # Do nothing if filter is already registered
    return if @filters[name]

    @filters[name] = true
    content_for :sidebar do
      yield
    end
  end

  # Tenancy
  def current_tenant
    current_user.try(:tenant)
  end

  include ActionView::Helpers::NumberHelper
  def currency_fmt(value)
    # We often do get -0.0 but don't like it
    value = 0.0 if value.to_s.match %r{^-[0.]*$}

    number = number_with_precision(value, :precision => 2, :separator => '.', :delimiter => "'")
  end

  # Nested form helpers
  def show_new_form(model)
    model_name = model.to_s.underscore

    output = <<EOF
$('##{model_name}_list').replaceWith('#{escape_javascript(render('form'))}');
addAutofocusBehaviour();
addAutocompleteBehaviour();
addDatePickerBehaviour();
addAutogrowBehaviour();
EOF

    return output.html_safe
  end
end
