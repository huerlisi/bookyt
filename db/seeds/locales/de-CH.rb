# Master Data
# ===========
# Swiss (German)

# Vat Rates
ChargeRate.create!([
  {:code => 'vat:full', :title => "MWSt.", :duration_from => '2011-01-01', :rate => 8, :relative => true},
  {:code => 'vat:reduced', :title => "MWSt.", :duration_from => '2011-01-01', :rate => 2.5, :relative => true},
  {:code => 'vat:special', :title => "MWSt.", :duration_from => '2011-01-01', :rate => 3.8, :relative => true},
  {:code => 'vat:excluded', :title => "MWSt. befreit", :duration_from => '2011-01-01', :rate => 0, :relative => true},
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
