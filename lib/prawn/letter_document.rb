module Prawn
  class LetterDocument < Prawn::Document

    include ApplicationHelper
    include ActionView::Helpers::TranslationHelper

    def initialize(opts = {})
      super
      
      # Default Font
      font_path = ::Rails.root.join('public/system/fonts/')
      font_families.update(
        "Angostura" => { :bold        => font_path.join('letter-bold.ttf'),
                         :normal      => font_path.join('letter-normal.ttf')})
      font "Angostura"
      font_size 13
    end

    # Draws the full address of a vcard
    def full_address(vcard)
      vcard.full_address_lines.each do |line|
        text line
      end
    end

    def header(sender)
      repeat :all do
        bounding_box [0, bounds.height + 130], :width => bounds.width, :height => 160 do
          indent bounds.width / 11 * 9 do
            full_address(sender.vcard)
          end

          # TODO use uploaded file from tenant
          # TODO think about requiring prawn-fast-png or only use PNGs with no transparency
          # You better use a bigger file as it gives better resolution
          image "#{::Rails.root}/public/images/letter-logo.png", :width => 150, :position => :left, :vposition => :top

        end
      end
    end

    def letter_head(sender, receiver)
      # define grid
      define_grid(:columns => 11, :rows => 16, :gutter => 2) #.show_all('EEEEEE')

      #Header start
      grid([0,7], [1,9]).bounding_box do
        full_address(receiver.vcard)
      end

      # Place'n'Date
      grid([3,7], [3,9]).bounding_box do
        text sender.vcard.locality + ", " + I18n.l(Date.today, :format => :long)
      end

      # Subject
      grid([4,0], [4,9]).bounding_box do
        text "<b>#{t('activerecord.models.invoice')}</b>", :inline_format => true, :character_spacing => 1.2
      end

    end

    def closing(subscriber_one, subscriber_two)
      move_down 30
      text I18n.t('letters.offer.disclaimer'), :style => :bold
      move_down 10

      table([[I18n.t("letters.offer.additional_infos.five.one"), I18n.t("letters.offer.additional_infos.five.two")],
            [I18n.t("letters.offer.additional_infos.parts.one"), I18n.t("letters.offer.additional_infos.parts.two")],
            [I18n.t("letters.offer.additional_infos.machine.one"), I18n.t("letters.offer.additional_infos.machine.two")],
            [I18n.t("letters.offer.additional_infos.machine_parts.one"), I18n.t("letters.offer.additional_infos.machine_parts.two")]],
            :width => 420,
            :cell_style => {:borders => [], :padding => [0, 0, 0, 0], :font_style => :bold},
            :column_widths => [120, 300])

      move_down 20
      text "Wir hoffen, Ihnen mit unserem Angebot zu dienen.", :style => :bold
      text "Für weitere Fragen stehen wir Ihnen zur Verfügung.", :style => :bold
      move_down 20

      indent(320) do
        text I18n.t('letters.offer.greetings'), :style => :bold
        move_down 10
        text I18n.t('letters.offer.signature'), :style => :bold
        move_down 30
        text "#{subscriber_one}         #{subscriber_two}", :style => :bold
      end
    end

    def line_items_table(offer)
      items = offer.line_items

      titles = [:amount, :description, :code, :price].inject([]) do |out, attr|
        out << make_cell(:content => I18n.t("letters.offer.#{attr}"), :background_color => "CFCFCF")
      end

      content = items.inject([]) do |out, item|
        if items.first.eql?item
          title = offer.product.description
        else
          title = item.title
        end

        times = "%ix" % item.times

        out << [times, title, item.code, currency_fmt(item.total_amount).to_s]
      end
      table([titles] + content, :width => bounds.width,
                      :cell_style => {:borders => [], :padding => [0, 0, 0, 0], :font_style => :bold},
                      :column_widths => [40, 300],
                      :header => true)
    end
  end
end
