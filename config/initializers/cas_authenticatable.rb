if Settings.devise_backend.to_sym == :cas_authenticatable
  begin
    require Rails.root.join('lib/cas_extra_attributes_mapper').to_s
  rescue LoadError
    fail 'Please add `cas_extra_attributes_mapper` file inside `/lib` and define class '\
         '`CASExtraAttributesMapper` first to use `cas_authenticatable`'
  end
end
