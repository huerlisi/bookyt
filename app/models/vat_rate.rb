class VatRate < ChargeRate
  scope :full, where(:code => 'full')
  scope :reduced, where(:code => 'reduced')
  scope :special, where(:code => 'special')
  scope :excluded, where(:code => 'excluded')
end
