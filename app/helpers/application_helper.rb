# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def sort_header(column, label = nil)
    label ||= column.humanize
    content_tag('th', label + ' ' + link_to(image_tag('up'), :order => column) + link_to(image_tag('down'), :order => column + ' DESC'))
  end

  def currency_fmt(value)
    sprintf("%.2f", value)
  end
end
