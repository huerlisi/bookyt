BEGIN {
  FS=";"
  OFS=";"
}

$2 ~ /E-Banking Auftrag/ {
  comment = $2
  valuta = $5
  to = 41 # Kreditoren CHF

  show = "false"
}

$2 ~ /Bancomatbezug/ {
  comment = $2
  amount = $3
  to = 1 # Kasse

  show = "true"
}

show == "false" {
  $2 ~ /CHF ([^ ]*)/
  title = $2
}

show == "true" {
  print valuta
  print amount
  print comment
  print to

}


$5 ~ /....-..-../ {
  valuta = $5
}

$1 != "" {
  comment = $2
}

$1 == "" {
  comment = $2
}

$2 ~/Auslandvergütung/ {
  value_ch = $4
}

/kjkjl/ {
  print comment, valuta, value_ch
}
