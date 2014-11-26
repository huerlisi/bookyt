require 'prawn/measurement_extensions'

class LetterDocument < Prawn::Document

  include ApplicationHelper
  include ActionView::Helpers::TranslationHelper
  include I18nRailsHelpers
  include Prawn::Measurements

  def h(s)
    return s
  end

  # Unescape HTML
  def html_unescape(value)
    # Return an empty string when value is nil.
    return '' unless value

    result = value

    result.gsub!(/<div>|<p>|<br>/, '')
    result.gsub!(/<\/div>|<\/p>|<\/br>|<br[ ]*\/>/, "\n")

    return result
  end

  # PDF compatible HTML helper wrappers
  def currency_fmt(value)
    CGI.unescapeHTML(super(value).to_str)
  end

  def initialize_fonts
    font 'Helvetica'
    font_size 9.5
  end

  def default_options
    {:page_size => 'A4'}
  end

  def initialize(opts = {})
    # Default options
    opts.reverse_merge!(default_options)

    # Set the template
    letter_template = Attachment.for_class(self.class)
    opts.reverse_merge!(:template => letter_template.file.current_path) if letter_template

    super

    # Default Font
    initialize_fonts
  end

  # Letter header with company logo, receiver address and place'n'date
  def letter_header(sender, receiver, subject, date = Date.today)
    move_down 60

    # Address
    float do
      canvas do
        bounding_box [12.cm, bounds.top - 6.cm], :width => 10.cm do
          draw_address(receiver.vcard)
        end
      end
    end

    move_down 3.5.cm

    # Place'n'Date
    sender_locality = sender.vcard.try(:locality)
    sender_date = date ? I18n.l(date, :format => :long) : nil
    text [sender_locality, sender_date].compact.join(', ')

    # Subject
    move_down 35
    text subject, :style => :bold
  end

  # Freetext
  def free_text(text = "")
    return unless text.present?

    text " "
    text html_unescape(text), :inline_format => true
  end

  def period(from, to)
    if from.present? && to.present?
      text "\nRechnungsperiode vom #{from} - #{to}\n"
    else
      text ""
    end

  end

  # Draws the full address of a vcard
  def draw_address(vcard, include_honorific_prefix = false)
    lines = [vcard.full_name, vcard.extended_address, vcard.street_address, vcard.post_office_box, "#{vcard.postal_code} #{vcard.locality}"]
    lines.unshift(vcard.honorific_prefix) if include_honorific_prefix

    # Strip all whitespace
    lines = lines.map {|line| line.strip if line.present?}.compact

    lines.each do |line|
      text line
    end
  end

  def common_closing(sender)
    text " "
    text " "

    text I18n.t('letters.greetings')
    text "#{sender.vcard.full_name}"
  end
end
