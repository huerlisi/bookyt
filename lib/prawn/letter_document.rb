module Prawn
  class LetterDocument < Prawn::Document

    include ApplicationHelper
    include ActionView::Helpers::TranslationHelper

    def initialize(opts = {})
      super
      
      # Default Font
      font  'Helvetica'
      font_size 10
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
        image ::Rails.root.join("app/assets/images/letter-logo.png"), :height => 50, :at => [0, bounds.top + 20]
      end
    end

    def closing(sender)
      text I18n.t('letters.debit_invoice.closing')

      text " "
      text " "

      indent(320) do
        text I18n.t('letters.greetings')
        text " "
        text "#{sender.vcard.full_name}"
      end
    end

    def line_items_table(invoice, line_items)
      content = line_items.collect do |item|
        # Only include quantity if different from one
        quantity = "%i x" % item.quantity if item.quantity != 1

        [item.date, item.title, quantity, currency_fmt(item.total_amount)]
      end

      total = ["Total", nil, nil, currency_fmt(invoice.amount)]

      rows = content + [total]
      table(rows, :width => bounds.width) do

        # General cell styling
        cells.valign  = :top
        cells.borders = []

        # Columns
        columns(2..3).align = :right
        column(0).width = 60
        column(2).width = 40
        column(3).width = 40
        column(0).padding_left = 0
        column(-1).padding_right = 0

        # Footer styling
        row(-1).font_style = :bold
      end
    end
  end
end
