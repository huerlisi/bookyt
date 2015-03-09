class SettingsController < ApplicationController
  # Actions
  def index
  end

  def vesr
    @tenant          = current_tenant
    @bank_account    = BankAccount.tagged_with('invoice:vesr').first
    @letter_template = Attachment.find_by_code('Prawn::LetterDocument') || Attachment.new
  end

  def update_vesr
    if params[:vesr][:attachment][:id].present?
      @letter_template = Attachment.find(params[:vesr][:attachment][:id])
      @letter_template.update_attributes(params[:vesr][:letter_template])
    else
      @letter_template = Attachment.new(params[:vesr][:attachment], :code => 'Prawn::LetterDocument')
    end

    @tenant = Tenant.find(params[:vesr][:tenant][:id])
    @tenant.update_attributes(params[:vesr][:tenant])

    if params[:vesr][:bank_account]
      @bank_account = BankAccount.find(params[:vesr][:bank_account][:id])
      @bank_account.update_attributes(params[:vesr][:bank_account])
    end

    render :action => 'vesr'
  end
end
