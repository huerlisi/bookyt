class AdaptDocumentTemplateCode < ActiveRecord::Migration
  def up
    Attachment.where(:code => 'Prawn::LetterDocument').update_all(:code => 'LetterDocument')
    Attachment.where(:code => 'Prawn::DebitInvoice').update_all(:code => 'DebitInvoiceDocument')
  end

  def down
    Attachment.where(:code => 'LetterDocument').update_all(:code => 'Prawn::LetterDocument')
    Attachment.where(:code => 'DebitInvoiceDocument').update_all(:code => 'Prawn::DebitInvoice')
  end
end
