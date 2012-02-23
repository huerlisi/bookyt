#!/bin/bash

file="$1"

function fix_csv() {
  recode latin1/crlf..utf8
}

function parse_chf_ebanking() {
local title="$1"

  grep "E-Banking" | sed -n 's/\(.*\);\(.*\) CHF \([^ ]*\) *\([^;]*\);;/\1;\2;\3;'"$title"';\1;/p' | tr -d "'"
}

function parse_gutschrift() {
local title="$1"

  add_title "$title" | sed -n 's/^\(.*\);CHF \([^ ]*\) *\([^;]*\);;/\1;\3;\2;/p' | tr -d "'"
}

function parse_eur_ebanking() {
  sed -n 's/^\(.*\);EUR \([^ ]*\) *\([^;]*\);;/\1;\3;\2;/p' | tr -d "'"
}

function add_value_date() {
  awk -F ';' 'BEGIN {OFS=";"}; $5 ~/....-..-../ {valuta = $5; title = $2; print}; $5 !~/....-..-../{print valuta, $2, $3, title, valuta}'
}

function add_value_and_title() {
  awk -F ';' 'BEGIN {OFS=";"}; $3 != "" {chf_value = $3; title = $2}; $3 == "" {print $1, $2, chf_value, title, $5}'
}

function add_chf_value_eur_ebanking() {
  awk -F ';' 'BEGIN {OFS=";"}; $2 ~/^(Vergütungsauftrag EUR|Auslandvergütung|E-Banking Auftrag EUR)/ {chf_value = $3; gsub(/ EUR .*/, "", $2); title = $2}; $2 ~/^EUR /{print $1, $2, chf_value, title, $5}'
}

function add_title() {
local title="$1"
local match="${2:-$title}"

  awk -F ';' 'BEGIN {OFS=";"}; $2 ~/'"$title"'/ {print $1, $2, $3, "'"$match"'", $5}'
}

function comment_as_title() {
local title="$1"
  awk -F ';' 'BEGIN {OFS=";"}; $2 ~/'$title'/ {print $1, "", $3, $2, $5}'
}

function parse_bancomat() {
  awk -F ';' 'BEGIN {OFS=";"}; {gsub("Bancomatbezug ", "", $2); print $1, $2, $3, "Bancomatbezug", $5}'
}

function csv2booking() {
local credit_account="$1"
local debit_account="$2"

  awk -F ';' '{print "Booking.create(:title => \""$4"\", :comments => \""$2"\", :debit_account_id => Account.find_by_code(\""'$debit_account'"\").id, :credit_account_id => Account.find_by_code(\""'$credit_account'"\").id, :amount => (" $3 ").abs, :value_date => \""$5"\")"}'
}


cat "$file" | fix_csv | add_value_date | parse_chf_ebanking 'E-Banking' | grep -v 'Details unterdrückt' | csv2booking 1080 1020
cat "$file" | fix_csv | add_value_date | parse_chf_ebanking 'Lohn' | grep 'Details unterdrückt' | csv2booking 1080 1020
cat "$file" | fix_csv | add_value_date | parse_chf_ebanking 'E-Banking Auftrag' | grep 'Details unterdrückt' | csv2booking 1080 1020
cat "$file" | fix_csv | add_value_date | add_title "Sollzins" | csv2booking 1080 1020
cat "$file" | fix_csv | add_value_date | add_title "Kreditkommission" | csv2booking 1080 1020
cat "$file" | fix_csv | add_value_date | add_title "Habenzins" | csv2booking 1020 1080
cat "$file" | fix_csv | add_value_date | add_title "Verrechnungssteuer" | csv2booking 1080 1020
cat "$file" | fix_csv | add_value_date | add_title "Kontoführungsgebühren" | csv2booking 1080 1020
cat "$file" | fix_csv | add_value_date | add_title "Gebühren" | csv2booking 1080 1020
cat "$file" | fix_csv | add_value_date | add_title "gebühr" "Gebühren"| csv2booking 1080 1020
cat "$file" | fix_csv | add_value_date | add_title "Versandspesen" | csv2booking 1080 1020
cat "$file" | fix_csv | add_value_date | add_chf_value_eur_ebanking | csv2booking 1080 1020
cat "$file" | fix_csv | add_value_date | comment_as_title 'Barauszahlung' | csv2booking 1080 1020
cat "$file" | fix_csv | add_value_date | add_title '[Bb]ancomat[-]?[Bb]ezug' 'Bancomatbezug' | csv2booking 1080 1020
cat "$file" | fix_csv | add_value_date | add_title 'Bareinzahlung' | grep -v 'Gebühr' | csv2booking 1020 1080
cat "$file" | fix_csv | add_value_date | add_title 'Einzahlung' | csv2booking 1020 1080
cat "$file" | fix_csv | add_value_date | add_value_and_title | grep 'Aduno' | csv2booking 1020 1080
cat "$file" | fix_csv | add_value_date | add_value_and_title | grep 'Gutschrift' | grep -v 'Gutschrift VESR' | grep -v 'Aduno' | csv2booking 1020 1080
cat "$file" | fix_csv | add_value_date | add_value_and_title | grep 'Postvergütung' | csv2booking 1020 1080
