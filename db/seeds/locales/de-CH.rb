# Master Data
# ===========
# Swiss (German)

# Vat Rates
VatRate.create!([
  {:code => 'full', :title => "MWSt. (Normaler Satz)", :duration_from => '2011-01-01', :rate => 8},
  {:code => 'reduced', :title => "MWSt. (Reduzierter Satz)", :duration_from => '2011-01-01', :rate => 2.5},
  {:code => 'special', :title => "MWSt. (Sondersatz)", :duration_from => '2011-01-01', :rate => 2.5},
  {:code => 'excluded', :title => "MWSt. befreit", :duration_from => '2011-01-01', :rate => 0},
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
