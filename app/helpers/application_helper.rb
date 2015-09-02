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

  def try_parse_date(date)
    begin
      date.is_a?(Date) ? date : Date.parse(date)
    rescue
    end
  end

  def link_to_by_year(period)
    from = try_parse_date(period[:from])
    to = try_parse_date(period[:to])

    title = by_year_to_s(from.year, to.year)

    link_to title, url_for(by_date: {from: from.to_s(:db), to: to.to_s(:db)})
  end

  # Date helper
  def get_by_year
    # Guard
    return unless by_date = session[:by_date].presence

    #raise by_date[:from].inspect
    from = Date.parse(by_date[:from])
    to = Date.parse(by_date[:to])

    by_year_to_s(from.year, to.year)
  end

  def by_year_to_s(from, to)
    if from == to
      to
    else
      "#{from} - #{to}"
    end
  end
end
