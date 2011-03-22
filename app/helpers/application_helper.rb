# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include ActionView::Helpers::NumberHelper
  
  def sort_header(column, label = nil)
    label ||= column.humanize
    content_tag('th', label.html_safe + ' '.html_safe + link_to(image_tag('up.png', :class => 'edit_controls'), :order => column) + link_to(image_tag('down.png', :class => 'edit_controls'), :order => column + ' DESC'))
  end

  def currency_fmt(value)
    # We often do get -0.0 but don't like it
    value = 0.0 if value.to_s.match %r{-[0]*[.0]*}
    
    number = number_with_precision(value, :precision => 2, :separator => '.', :delimiter => "'")
  end

  def cu_to_s(value, unit = 'CHF')
    "<span style=\"float: left\">#{unit}&nbsp;</span>".html_safe + number_to_currency(value, :unit => '').html_safe
  end

  def icon_edit_link_to(path)
    link_to t('bookyt.edit'), path, :method => :get, :class => 'icon-tooltip icon-edit-text', :title => t('bookyt.edit')
  end

  def icon_delete_link_to(model, path)
    link_to t('bookyt.destroy'), path, :remote => true, :method => :delete, :confirm => t_confirm_delete(model), :class => 'icon-tooltip icon-delete-text', :title => t('bookyt.destroy')
  end

  # CRUD helpers
  def icon_link_to(action, url, options = {})
    options.merge!(:class => "icon icon-#{action}")
    
    link_to(t_action(action), url, options)
  end
  
  def contextual_link_to(action, resource_or_model = nil)
    # Handle both symbols and strings
    action = action.to_s
    
    # Resource and Model setup
    # Use controller name to guess resource or model if not specified
    case action
    when 'new', 'index'
      model = resource_or_model || controller_name.singularize.camelize.constantize
    when 'show', 'edit', 'delete'
      resource = resource_or_model || instance_variable_get("@#{controller_name.singularize}")
      model = resource.class
    end
    model_name = model.to_s.underscore
    
    # Return if current user isn't authorized to call this action
    return unless can?(action.to_sym, model)
    
    # Link generation
    case action
    when 'new'
      return icon_link_to(action, send("new_#{model_name}_path"))
    when 'show'
      return icon_link_to(action, send("#{model_name}_path", resource))
    when 'edit'
      return icon_link_to(action, send("edit_#{model_name}_path", resource))
    when 'delete'
      return icon_link_to(action, send("#{model_name}_path", resource), :confirm => t_confirm_delete(resource), :method => :delete)
    when 'index'
      return icon_link_to(action, send("#{model_name.pluralize}_path"))
    end
  end
  
  def contextual_links_for(action = nil, resource_or_model = nil)
    # Use current action if not specified
    action ||= action_name
    
    # Handle both symbols and strings
    action = action.to_s
    
    actions = []
    case action
    when 'new', 'create'
      actions << 'index'
    when 'show'
      actions += ['edit', 'delete', 'index']
    when 'edit', 'update'
      actions += ['show', 'delete', 'index']
    when 'index'
      actions << 'new'
    end
    
    links = actions.map{|link_for| contextual_link_to(link_for, resource_or_model)}
    
    return links.join("\n").html_safe
  end
  
  def contextual_links(action = nil, resource_or_model = nil)
    content_tag('div', :class => 'contextual') do
      contextual_links_for(action, resource_or_model)
    end
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
