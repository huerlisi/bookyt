#!/usr/bin/ruby

require 'csv'
f = File.open(ARGV[1], 'r')

lines = CSV::Reader.parse(f, ';')
line = lines.to_a

records = line.select {|l| l[1] =~ /^.*Nachttresor.*/ }
records.each { |record|
  booking = Booking.new(:title => record[1], :debit_account_id => 1, :credit_account_id => 2, :amount => record[2], :value_date => record[4])
  booking.save
}
