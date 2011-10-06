module Prawn
  module EsrRecipe
    def esr_recipe(invoice, esr_account, sender)
      draw_text esr9(invoice, esr_account), :at => [cm2pt(5.2), 0]
    end

    private
    # ESR helpers
    def esr9(invoice, esr_account)
      esr9_build(invoice.amount, invoice, esr_account.pc_id, esr_account.esr_id)
    end

    def esr9_build(esr_amount, invoice, biller_id, esr_id)
      # 01 is type 'Einzahlung in CHF'
      amount_string = "01#{sprintf('%011.2f', esr_amount).delete('.')}"
      id_string = esr_number(esr_id, invoice.customer.id)
      biller_string = esr9_format_account_id(biller_id)

      "#{esr9_add_validation_digit(amount_string)}>#{esr9_add_validation_digit(id_string)}+ #{biller_string}>"
    end

    def esr_number(esr_id, patient_id)
      esr_id.to_s + sprintf('%013i', patient_id).delete(' ') + sprintf('%07i', id).delete(' ')
    end

    def esr9_add_validation_digit(value)
      # Defined at http://www.pruefziffernberechnung.de/E/Einzahlungsschein-CH.shtml
      esr9_table = [0, 9, 4, 6, 8, 2, 7, 1, 3, 5]
      digit = 0
      value.split('').map{|c| digit = esr9_table[(digit + c.to_i) % 10]}
      digit = (10 - digit) % 10

      "#{value}#{digit}"
    end

    def esr9_format(reference_code)
      # Drop all leading zeroes
      reference_code.gsub!(/^0*/, '')

      # Group by 5 digit blocks, beginning at the right side
      reference_code.reverse.gsub(/(.....)/, '\1 ').reverse
    end

    def esr9_format_account_id(account_id)
      (pre, main, post) = account_id.split('-')

      sprintf('%02i%06i%1i', pre, main, post)
    end
  end
end