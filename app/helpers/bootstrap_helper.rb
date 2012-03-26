module BootstrapHelper
  def boot_page_title(action = nil, model = nil)
    title = t_title(action, model)
    content_for :page_title, title
    content_tag(:div, :class => 'page-header') do
      content_tag(:h1, title)
    end
  end

  def boot_label(content, type = nil)
    return "" unless content.present?

    classes = ['label', "label-#{type}"].compact.join(' ')
    content_tag(:span, content, :class => classes)
  end

  def boot_alert(content, type = 'info')
    content_tag(:div, :class => "alert alert-block alert-info") do
      link_to('&times;'.html_safe, '#', :class => 'close') + content
    end
  end
end
