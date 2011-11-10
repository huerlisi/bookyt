class SettingsController < ApplicationController
  # Actions
  def index
  end

  def vesr
    @tenant          = current_tenant
    @bank_account    = BankAccount.find_by_code('1020')
    @letter_template = Attachment.find_by_code('Prawn::LetterDocument') || Attachment.new
  end

  def update_vesr
    @tenant          = Tenant.find(params[:vesr][:tenant][:id])
    @bank_account    = BankAccount.find(params[:vesr][:bank_account][:id])
    if params[:vesr][:attachment][:id].present?
      @letter_template = Attachment.find(params[:vesr][:attachment][:id])
      @letter_template.update_attributes(params[:vesr][:letter_template])
    else
      @letter_template = Attachment.new(params[:vesr][:attachment], :code => 'Prawn::LetterDocument')
    end

    @tenant.update_attributes(params[:vesr][:tenant])
    @bank_account.update_attributes(params[:vesr][:bank_account])

    render :action => 'vesr'
  end
end
