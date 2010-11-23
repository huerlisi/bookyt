require 'csv'
f = File.open('/home/shuerlimann/agrabah-raiffeisen-2008-parsed.csv', 'r')

lines = CSV::Reader.parse(f, ';')
a = lines.to_a

aduno_zahlung = a.select {|l| l[1] =~ /^.*Aduno.*/ }
aduno_zahlung.each{ |l|
  b = Booking.new(:title => l[1], :debit_account_id => 49, :credit_account_id => 2, :amount => l[2], :value_date => l[4])
  b.save
}

aduno_kommission = a.select {|l| l[1] =~ /^.*ADUNO.*/ }
aduno_kommission.each {|k|
  k[1] =~ /KOM. ([^ ]*)/
  kommission = $1
  k[1] =~ /(REF. NO. [^ ]* DOK NR. [^ ]*)/
  title = $1

  if kommission then
    amount = kommission.gsub(',', '.').to_f.currency_round
    b = Booking.new(:title => title, :debit_account_id => 49, :credit_account_id => 39, :amount => amount, :value_date => k[0])
    b.save
  end
}
