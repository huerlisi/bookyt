module BootstrapHelper
  def boot_label(content, type = nil)
    return "" unless content.present?

    classes = ['label', type].compact.join(' ')
    content_tag(:span, content, :class => classes)
  end

  def boot_alert(content, type = 'info')
    content_tag(:div, :class => "alert-message block-message fade in #{type}", 'data-alert' => 'alert') do
      link_to('&times;'.html_safe, '#', :class => 'close') + content
    end
  end
end
