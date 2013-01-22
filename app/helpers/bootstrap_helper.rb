module BootstrapHelper
  def boot_page_title(action_or_title = nil, model = nil)
    if action_or_title.is_a? String
      title = action_or_title
    else
      action = action_or_title || action_name
      if action.to_s == 'show' && defined?(resource) && resource.present?
        title = resource.to_s
      else
        title = t_title(action, model)
      end
    end

    content_for :page_title, title
    content_tag(:div, :class => 'page-header') do
      content_tag(:h1, title)
    end
  end

  # Icons
  # =====
  def boot_icon(type)
    content_tag(:i, '', :class => "icon-#{type}")
  end

  # Labels
  # ======
  def boot_label(content, type = nil)
    return "" unless content.present?

    classes = ['label', "label-#{type}"].compact.join(' ')
    content_tag(:span, content, :class => classes)
  end

  # Modal
  # =====
  def modal_header(title)
    content_tag(:div, :class => 'modal-header') do
      content_tag(:button, '&times;'.html_safe, :type => 'button', :class => 'close', 'data-dismiss' => 'modal') +
      content_tag(:h3, title)
    end
  end

  # Messages
  # ========
  def boot_alert(*args, &block)
    if block_given?
      type = args[0]
      content = capture(&block)
    else
      content = args[0]
      type    = args[1]
    end

    type ||= 'info'
    content_tag(:div, :class => "alert alert-block alert-#{type} fade in") do
      link_to('&times;'.html_safe, '#', :class => 'close', 'data-dismiss' => 'alert') + content
    end
  end

  def boot_no_entry_alert
    boot_alert t('alerts.empty')
  end

  # Navigation
  # ==========
  def boot_nav_header(title, refresh_action = false)
    if title.is_a? Symbol
      title = t("#{title}.title")
    end

    content_tag(:li, :class => 'nav-header') do
      content = [title]
      if refresh_action
        content << content_tag(:button, :type => "submit", :style => 'border: none; background-color: transparent; float: right') do
          content_tag(:i, "", :class => 'icon-refresh')
        end
      end

      content.join("\n").html_safe
    end
  end

  def boot_nav_li_link(filter_name, param_value, title = nil, param_name = filter_name, current_value = params[param_name], classes = [], &content)
    classes << "active" if current_value.to_s == param_value.to_s
    title ||= param_value
    title = t("#{filter_name.to_s}.#{title}", :default => title)

    if block_given?
      content_tag(:li, :class => classes, &content)
    else
      content_tag(:li, :class => classes) do
        url = url_for(params.merge({param_name => param_value}))
        link_to title, url
      end
    end
  end

  def boot_nav_li_checkbox(filter_name, param_value, title = nil, param_name = filter_name, current_value = params[param_name], classes = [], &content)
    active = current_value.include? param_value.to_s
    classes << "active" if active

    title ||= param_value
    title = t("#{filter_name.to_s}.#{title}", :default => title)

    if block_given?
      content_tag(:li, :class => classes, &content)
    else
      content_tag(:li, :class => classes) do
        content_tag 'label', :class => 'checkbox' do
          content = []
          content << content_tag('input', '', :type => 'checkbox', :checked => active, :name => "#{param_name}[]", :value => param_value)
          content << title

          content.join("\n").html_safe
        end
      end
    end
  end

  def boot_nav_filter(name, entries, type = :link)
    refresh_action = (type == :checkbox)

    content_tag(:ul, :class => ['nav', 'nav-list']) do
      content = []
      content << boot_nav_header(name, refresh_action)

      entries.each do |entry|
        if entry.is_a? Hash
          title = entry[:title]
          value = entry[:value]
        else
          title = value = entry
        end

        case type
        when :link
          content << boot_nav_li_link(name, value, title)
        when :checkbox
          content << boot_nav_li_checkbox(name, value, title)
        end
      end

      content.join("\n").html_safe
    end
  end
end
