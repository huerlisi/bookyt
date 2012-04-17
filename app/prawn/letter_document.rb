require 'prawn/measurement_extensions'

class LetterDocument < Prawn::Document

  include ApplicationHelper
  include ActionView::Helpers::TranslationHelper
  include I18nRailsHelpers
  include Prawn::Measurements

  # Unescape HTML
  def html_unescape(value)
    # Return an empty string when value is nil.
    return '' unless value

    result = value

    result.gsub!(/<div>|<p>|<br>/, '')
    result.gsub!(/<\/div>|<\/p>|<\/br>|<br[ ]*\/>/, "\n")

    return result
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
    text [sender.vcard.try(:locality), I18n.l(date, :format => :long)].compact.join(', ')

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

  # Draws the full address of a vcard
  def draw_address(vcard)
    lines = [vcard.full_name, vcard.extended_address, vcard.street_address, vcard.post_office_box, "#{vcard.postal_code} #{vcard.locality}"]
    lines = lines.map {|line| line.strip unless (line.nil? or line.strip.empty?)}.compact

    lines.each do |line|
      text line
    end
  end

  def footer(sender, bank_account, vat_number, vesr_included)
    height = vesr_included ? 310 : 20
    height -= 20 unless bank_account and bank_account.bank
    title_width = 45
    sender_vcard = sender.vcard
    bank_vcard = bank_account.bank.vcard
    line_spacing = 2

    bounding_box [bounds.left, height], :width => title_width, :height => 40 do
      font_size 7 do
        text "Begünstigter:"
        if bank_account and bank_account.bank
          move_down line_spacing
          text "Bank:"
          move_down line_spacing
          text "Konto:"
        end
      end
    end

    bounding_box [bounds.left + title_width, height], :width => bounds.width - title_width, :height => 40 do
      font_size 7 do
        text "#{sender_vcard.full_name} – #{sender_vcard.extended_address + " – " unless sender_vcard.extended_address.blank?}#{sender_vcard.street_address} – #{sender_vcard.postal_code} #{sender_vcard.locality}"
        if bank_account and bank_account.bank
          move_down line_spacing
          text "#{bank_vcard.full_name} – #{bank_vcard.street_address + " – " if bank_vcard.street_address.present?}#{bank_vcard.postal_code} #{bank_vcard.locality}"
          move_down line_spacing
          bank_text_line = [
                              bank_account.iban.present? ? "IBAN: #{bank_account.iban}" : nil,
                              bank_account.bank.swift.present? ? "SWIFT: #{bank_account.bank.swift}" : nil,
                              bank_account.bank.clearing.present? ? "Clearing: #{bank_account.bank.clearing}" : nil,
                              bank_account.pc_id.present? ? "PC-Konto: #{bank_account.pc_id}" : nil,
                              vat_number.present? ? "MWSt.-Nr.: #{vat_number}" : nil
                            ].compact.join(" – ")

          text bank_text_line
        end
      end
    end
  end

  def invoice_closing(sender, due_date)
    text " "
    text I18n.t('letters.debit_invoice.closing', :due_date => due_date), :align => :justify

    common_closing(sender)
  end

  def common_closing(sender)
    text " "
    text " "

    text I18n.t('letters.greetings')
    text "#{sender.vcard.full_name}"
  end

  def line_items_table(invoice, line_items)
    text " "
    content = line_items.collect do |item|

     amount = item.times_to_s

      price = currency_fmt(item.price)

      [item.title, item.date, amount, price, currency_fmt(item.total_amount)]
    end

    rows = content + [total_row(currency_fmt(invoice.amount))]

    items_table(rows)
  end

  def total_row(amount)
    ["Total", nil, nil, nil, amount]
  end

  def items_table(rows)
    table(rows, :width => bounds.width) do

      # General cell styling
      cells.valign  = :top
      cells.borders = []
      cells.padding_bottom = 0
      cells.padding_top = 0

      # Columns
      columns(2..4).align = :right
      column(1).width = 65
      column(2).width = 75
      column(3).width = 65
      column(4).width = 65
      column(0).padding_left = 0
      column(-1).padding_right = 0

      # Footer styling
      row(-1).font_style = :bold
    end
  end

  def payment_order(sender, bank_account, invoice)
    draw_text invoice.esr9(bank_account), :at => [cm2pt(5.2), 0]
  end
end
