require 'csv-mapper'

module RaiffeisenImporter
  def self.import(file)
    results = CsvMapper.import(file) do
      delimited_by ';'
      start_at_row 1
      # Booked At;Text;Credit/Debit Amount;Balance;Valuta Date
      [booked_at, text, credit, balance, valuta_date]
    end
    results.each do |r|
      BookingTemplate.import(r)
    end
  end
end