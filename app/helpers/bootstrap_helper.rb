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

  def boot_nav_header(title)
    if title.is_a? Symbol
      title = t("#{title}.title")
    end

    content_tag(:li, title, :class => 'nav-header')
  end

  def boot_nav_li(filter_name, param_value, title = nil, param_name = filter_name, current_value = params[param_name], classes = [], &content)
    classes << "active" if current_value == param_value
    title ||= param_value
    title = t("#{filter_name.to_s}.#{title}") if title.is_a? Symbol

    if block_given?
      content_tag(:li, :class => classes, &content)
    else
      content_tag(:li, :class => classes) do
        url = url_for(params.merge({param_name => param_value}))
        link_to title, url
      end
    end
  end

  def boot_nav_filter(name, values)
    content_tag(:ul, :class => ['nav', 'nav-list']) do
      content = []
      content << boot_nav_header(name)

      values.each do |value|
        if value.is_a? Hash
          content << boot_nav_li(name, value[:value], value[:title])
        else
          content << boot_nav_li(name, value)
        end
      end

      content.join("\n").html_safe
    end
  end
end
