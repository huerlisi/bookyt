Factory.define :cash_account, :class => Account do |a|
  a.title 'Kasse Laden'
  a.code '1010'
end

Factory.define :eft_account, :class => Account do |a|
  a.title 'EFT Kontokorrent'
  a.code '1021'
end

Factory.define :service_account, :class => Account do |a|
  a.title 'Dienstleistungsertrag'
  a.code '3200'
end


