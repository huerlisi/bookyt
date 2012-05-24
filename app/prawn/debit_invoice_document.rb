class DebitInvoiceDocument < LetterDocument
  include Prawn::EsrRecipe

  def invoice_closing(sender, due_date)
    text " "
    text I18n.t('letters.debit_invoice.closing', :due_date => due_date), :align => :justify

    text " "

    text I18n.t('letters.debit_invoice.greetings')
    text "#{sender.vcard.full_name}"
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

  def line_items_table(invoice, line_items)
    text " "
    content = line_items.collect do |item|
      amount = item.times_to_s
      price = currency_fmt(item.price)

      [item.title, item.date, amount, price, currency_fmt(item.accounted_amount)]
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
