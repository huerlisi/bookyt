module Bookyt
  class API
    class DebitInvoices < Grape::API
      helpers do
        def debit_invoice_params
          attributes = params.except(:line_items)
          attributes[:company_id] = current_tenant.company.id
          attributes[:line_items_attributes] = line_items_attributes
          attributes
        end

        def line_items_attributes
          params[:line_items].map do |line_item|
            item = line_item.except(:credit_account_tag, :debit_account_tag)
            item[:credit_account] = Account.find_by_tag(line_item[:credit_account_tag])
            item[:debit_account] = Account.find_by_tag(line_item[:debit_account_tag])
            item
          end
        end
      end

      resource :debit_invoices do
        desc 'Fetch all the debit_invoices'
        get do
          debit_invoices = DebitInvoice.all
          present debit_invoices, with: Bookyt::Entities::DebitInvoice
        end

        desc 'Create a new debit_invoice'
        params do
          requires :title, type: String, desc: 'Title of the invoice'
          requires :customer_id, type: Integer, desc: 'Addressed customer id'
          requires :state, type: String, values: Invoice::STATES, default: 'booked', desc: 'Current state'
          requires :value_date, type: Date, desc: 'Value date of the invoice'
          requires :due_date, type: Date, desc: 'Due date of the invoice'

          optional :duration_from, type: Date, desc: 'Duration start of the invoice'
          optional :duration_to, type: Date, desc: 'Duration end of the invoice'
          optional :text, type: String, desc: 'Additional invoice text, visible to customer'
          optional :remarks, type: String, desc: 'Internal remarks, not visible to customer'

          requires :line_items, type: Array do
            requires :title, type: String, desc: 'Title/Description of the line item'
            requires :times, type: Integer, default: 1, desc: 'Price multiplier'
            requires :quantity, type: String, default: 'x', values: %w(x hours overall %), desc: 'Quantity'
            requires :price, type: BigDecimal, desc: 'Price of the line item, without modifiers applied'
            requires :credit_account_tag, type: String, desc: 'Tag of the credit account'
            requires :debit_account_tag, type: String, desc: 'Tag of the debit account'

            optional :date, type: Date, desc: 'Date of the line item'
          end
        end
        post do
          debit_invoice = DebitInvoice.create!(debit_invoice_params)
          present debit_invoice, with: Bookyt::Entities::DebitInvoice
        end

        route_param :id do
          desc 'Fetch a debit_invoice'
          get do
            debit_invoice = DebitInvoice.find(params[:id])
            present debit_invoice, with: Bookyt::Entities::DebitInvoice
          end

          desc 'Fetch a debit_invoice as pdf'
          get 'pdf' do
            debit_invoice = DebitInvoice.find(params[:id])
            pdf = DebitInvoicePDF.new(debit_invoice, current_tenant)
            content_type Mime::Type.lookup_by_extension('pdf').to_s
            env['api.format'] = :binary
            header 'Content-Disposition', "attachment; filename=#{URI.escape(pdf.filename)}"
            pdf.call
          end

          desc 'Update a debit_invoice'
          params do
            requires :title, type: String, desc: 'Title of the invoice'
            requires :customer_id, type: Integer, desc: 'Addressed customer id'
            requires :state, type: String, values: Invoice::STATES, default: 'booked', desc: 'Current state'
            requires :value_date, type: Date, desc: 'Value date of the invoice'
            requires :due_date, type: Date, desc: 'Due date of the invoice'

            optional :duration_from, type: Date, desc: 'Duration start of the invoice'
            optional :duration_to, type: Date, desc: 'Duration end of the invoice'
            optional :text, type: String, desc: 'Additional invoice text, visible to customer'
            optional :remarks, type: String, desc: 'Internal remarks, not visible to customer'

            requires :line_items, type: Array do
              requires :title, type: String, desc: 'Title/Description of the line item'
              requires :times, type: Integer, default: 1, desc: 'Price multiplier'
              requires :quantity, type: String, default: 'x', values: %w(x hours overall %), desc: 'Quantity'
              requires :price, type: BigDecimal, desc: 'Price of the line item, without modifiers applied'
              requires :credit_account_tag, type: String, desc: 'Tag of the credit account'
              requires :debit_account_tag, type: String, desc: 'Tag of the debit account'

              optional :date, type: Date, desc: 'Date of the line item'
            end
          end
          put do
            debit_invoice = DebitInvoice.find(params[:id])
            debit_invoice.update_attributes!(debit_invoice_params)
            present debit_invoice, with: Bookyt::Entities::DebitInvoice
          end

          desc 'Delete a debit_invoice'
          delete do
            DebitInvoice.find(params[:id]).destroy
            status 204
          end
        end
      end
    end
  end
end
