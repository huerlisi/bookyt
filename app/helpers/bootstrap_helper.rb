module BootstrapHelper
  def boot_label(content, type = nil)
    return "" unless content.present?

    classes = ['label', type].compact.join(' ')
    content_tag(:span, content, :class => classes)
  end
end
