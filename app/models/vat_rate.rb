class VatRate < ChargeRate
  scope :full, where(:code => 'full')
  scope :reduced, where(:code => 'reduced')
  scope :special, where(:code => 'special')
  scope :excluded, where(:code => 'excluded')

  # String
  def to_s
    "%.1f%% (%s)" % [rate, I18n::translate(code, :scope => 'vat_rates.code')]
  end
end
