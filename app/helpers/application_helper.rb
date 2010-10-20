# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include ActionView::Helpers::NumberHelper
  
  def sort_header(column, label = nil)
    label ||= column.humanize
    content_tag('th', label.html_safe + ' '.html_safe + link_to(image_tag('up.png', :class => 'edit_controls'), :order => column) + link_to(image_tag('down.png', :class => 'edit_controls'), :order => column + ' DESC'))
  end

  def currency_fmt(value)
    number_with_precision(value, :precision => 2, :separator => '.', :delimiter => "'")
  end

  def cu_to_s(value, unit = 'CHF')
    "<span style=\"float: left\">#{unit}&nbsp;</span>".html_safe + number_to_currency(value, :unit => '').html_safe
  end

  def icon_edit_link_to(path)
    link_to t('bookyt.edit'), path, :method => :get, :class => 'icon-edit-text', :title => t('bookyt.edit')
  end

  def icon_delete_link_to(model, path)
    link_to t('bookyt.destroy'), path, :remote => true, :method => :delete, :confirm => t_confirm_delete(model), :class => 'icon-delete-text', :title => t('bookyt.destroy')
  end
end
