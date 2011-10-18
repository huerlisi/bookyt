require 'vesr'

module Prawn
  class LetterDocument < Prawn::Document

    include ApplicationHelper
    include ActionView::Helpers::TranslationHelper
    include Prawn::Measurements
    include EsrRecipe

    def initialize(opts = {})
      super
      
      # Default Font
      font  'Helvetica'
      font_size 11
    end

    # Draws the full address of a vcard
    def full_address(vcard)
      vcard.full_address_lines.each do |line|
        text line
      end
    end

    def header(sender)
      repeat :all do
        # TODO use uploaded file from tenant
        # TODO think about requiring prawn-fast-png or only use PNGs with no transparency
        # You better use a bigger file as it gives better resolution
        logo = ::Rails.root.join("public/system/images/letter-logo.png")
        image logo, :height => 50, :at => [0, bounds.top + 20] if logo.exist?
      end
    end

    def footer(sender, bank_account)
      repeat :all do
        bounding_box [bounds.left, 35], :width => 120, :height => 40 do
          font_size 7 do
            vcard = sender.vcard

            text "Begünstigter:"
            text vcard.full_name
            text vcard.extended_address unless vcard.extended_address.blank?
            text vcard.street_address
            text vcard.postal_code + " " + vcard.locality
          end
        end

        if bank_account and bank_account.bank
          bounding_box [bounds.left + 190, 35], :width => 120, :height => 40 do
            font_size 7 do
              vcard = bank_account.bank.vcard

              text "Bank:"
              text vcard.full_name
              text vcard.street_address if vcard.street_address.present?
              locality = [vcard.postal_code, vcard.locality].compact.join(', ')
              text locality if locality.present?
            end
          end

          bounding_box [bounds.left + 360, 35], :width => 120, :height => 40 do
            font_size 7 do
              vcard = bank_account.bank.vcard

              text "Konto:"
              text "IBAN: " + bank_account.iban if bank_account.iban.present?
              text "SWIFT: " + bank_account.bank.swift if bank_account.bank.swift.present?
              text "Clearing: " + bank_account.bank.clearing if bank_account.bank.clearing.present?
              text "PC-Konto: " + bank_account.pc_id if bank_account.pc_id.present?
            end
          end
        end
      end
    end

    def closing(sender, due_date)
      text I18n.t('letters.debit_invoice.closing', :due_date => due_date), :align => :justify

      text " "
      text " "

      text I18n.t('letters.greetings')
      text " "
      text "#{sender.vcard.full_name}"
    end

    def line_items_table(invoice, line_items)
      content = line_items.collect do |item|

        if item.times == 1
          if item.quantity == "x"
            amount = ""
          elsif item.quantity == "overall"
            amount = t('line_items.quantity.overall')
          else
            amount = "#{item.times} #{t(item.quantity, :scope => 'line_items.quantity')}"
          end
        else
          amount = "#{currency_fmt(item.times)} #{t(item.quantity, :scope => 'line_items.quantity')}"
        end

       price = currency_fmt(item.price)

       [item.title, item.date, amount, price, currency_fmt(item.total_amount)]
      end

      total = ["Total", nil, nil, nil, currency_fmt(invoice.amount)]

      rows = content + [total]
      table(rows, :width => bounds.width) do

        # General cell styling
        cells.valign  = :top
        cells.borders = []

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
end
