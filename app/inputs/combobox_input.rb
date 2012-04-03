class ComboboxInput < SimpleForm::Inputs::CollectionSelectInput
  include ActionView::Helpers::UrlHelper
  include BootstrapHelper

  def link_fragment
    reference = object.send(reflection.name)

    if reference
      template.content_tag('span', template.link_to(boot_icon("eye-open"), object.send(reflection.name)), :class => 'combobox-link')
    else
      url_method = "new_#{reflection.name}_#{object.class.model_name.underscore.pluralize}_url"
      if template.respond_to?(url_method)
        template.content_tag('span', template.link_to(boot_icon("plus"), template.send(url_method), :remote => true), :class => "combobox-link new_#{reflection.name}")
      end
    end
  end

  def input
    super + link_fragment
  end
end
