#!/usr/bin/ruby

for line in STDIN
  fields = line.split(';')
  valuta = ""

  # If details
  if fields[0] == ""
    entry = fields[1]

    fields[0] = valuta

    if entry =~ /(CHF) ([^ ]*) *(.*)$/
      fields[2] = $2.chomp
      fields[1] = $3.chomp
    elsif entry =~ /(EUR) ([^ ]*) *(.*)$/
      fields[2] = $2.chomp
      fields[1] = $3.chomp
    end
    puts fields.join(';')
  else
    valuta = fields[4].chomp
    puts fields[0,3].join(';')
  end
end
