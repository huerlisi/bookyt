# Role factories
Factory.define :admin, :class => Role do |f|
  f.name "admin"
end

Factory.define :accountant, :class => Role do |f|
  f.name "accountant"
end
