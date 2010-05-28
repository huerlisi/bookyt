# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def sort_header(column, label = nil)
    label ||= column.humanize
    content_tag('th', label.html_safe + ' '.html_safe + link_to(image_tag('up.png', :class => 'edit_controls'), :order => column) + link_to(image_tag('down.png', :class => 'edit_controls'), :order => column + ' DESC'))
  end

  def currency_fmt(value)
    sprintf("%.2f", value)
  end

  def cu_to_s(value, unit = 'CHF')
    "<span style=\"float: left\">#{unit}&nbsp;</span>".html_save + number_to_currency(value, :unit => '').html_save
  end
end
