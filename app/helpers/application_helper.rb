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

  # CRUD helpers
  def icon_edit_link_to(path)
    link_to t('bookyt.edit'), path, :method => :get, :class => 'icon-edit-text', :title => t('bookyt.edit')
  end

  def icon_delete_link_to(model, path)
    link_to t('bookyt.destroy'), path, :remote => true, :method => :delete, :confirm => t_confirm_delete(model), :class => 'icon-delete-text', :title => t('bookyt.destroy')
  end

  def list_item_actions_for(resource)
    model_name = resource.class.to_s.underscore

    render 'layouts/list_item_actions_for', :model_name => model_name, :resource => resource
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
