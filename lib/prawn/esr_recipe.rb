module Prawn
  module EsrRecipe
    def esr_recipe(invoice, esr_account, sender)
      draw_text invoice.esr9(esr_account), :at => [cm2pt(5.2), 0]
    end
  end
end