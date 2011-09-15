# Master Data
# ===========
# Swiss (German)

# Vat Rates
VatRate.create!([
  {:code => 'vat:full', :title => "MWSt. (Normaler Satz)", :duration_from => '2011-01-01', :rate => 8},
  {:code => 'vat:reduced', :title => "MWSt. (Reduzierter Satz)", :duration_from => '2011-01-01', :rate => 2.5},
  {:code => 'vat:special', :title => "MWSt. (Sondersatz)", :duration_from => '2011-01-01', :rate => 2.5},
  {:code => 'vat:excluded', :title => "MWSt. befreit", :duration_from => '2011-01-01', :rate => 0},
])
