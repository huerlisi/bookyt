# Master Data
# ===========
# Swiss (German)

# Vat Rates
ChargeRate.create!([
  {:code => 'vat:normal', :title => "MWSt. (Normaler Satz)", :duration_from => '2011-01-01', :rate => 8},
  {:code => 'vat:reduced', :title => "MWSt. (Reduzierter Satz)", :duration_from => '2011-01-01', :rate => 2.5},
  {:code => 'vat:special', :title => "MWSt. (Sondersatz)", :duration_from => '2011-01-01', :rate => 2.5},
  {:code => 'vat:excluded', :title => "MWSt. befreit", :duration_from => '2011-01-01', :rate => 0},
])

CivilStatus.create!([
  {:name => "Ledig"}, 
  {:name => "Verheiratet"},
  {:name => "Geschieden"}, 
  {:name => "Verwitwet"}
])

Religion.create!([
  {:name => "Römisch-Katholisch"},
  {:name => "Reformiert"},
  {:name => "Orthodox"},
  {:name => "Islam"},
  {:name => "Jüdisch"},
  {:name => "Konfessionslos"}
])
