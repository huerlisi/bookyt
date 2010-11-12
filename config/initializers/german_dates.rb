# Use german, human readable date and time formats.
Date::DATE_FORMATS[:default] = '%d.%m.%Y'
Time::DATE_FORMATS[:default] = '%d.%m.%Y %H:%M'

Date::DATE_FORMATS[:text_field] = lambda {|value| value.strftime('%d.%m.%Y').gsub(/^0/, "").gsub(/\.0/, ".")}
Time::DATE_FORMATS[:text_field] = '%d.%m.%Y %H:%M'
