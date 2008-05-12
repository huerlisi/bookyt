# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def sort_header(column, label = nil)
    label ||= column.humanize
    content_tag('th', label + ' ' + link_to(image_tag('up.png'), :order => column) + link_to(image_tag('down.png'), :order => column + ' DESC'))
  end

  def currency_fmt(value)
    sprintf("%.2f", value)
  end

  def cu_to_s(value)
    '<span style="float: left">CHF&nbsp;</span>' + number_to_currency(value, :unit => '')
  end
end
