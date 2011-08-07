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
        quantity = "%i x" % item.quantity

        [quantity, item.title, currency_fmt(item.total_amount)]
      end

      total = ["Total", nil, currency_fmt(invoice.amount)]

      rows = content + [total]
      table(rows, :width => bounds.width,
                  :column_widths => [40, 300]) do

        # General cell styling
        cells.valign  = :top
        cells.borders = []
        cells.padding = [0, 0, 0, 0]

        # Columns
        column(2).align = :right

        # Footer styling
        row(-1).font_style = :bold
      end
    end
  end
end
