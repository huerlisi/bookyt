module Bookyt
  class API
    class Invoices < Grape::API
      helpers do
        def create_debit_invoice?
          declared(params)[:type] == 'debit'
        end

        def invoice_params
          attributes = declared(params).except(:line_items, :type, :address_id)
          attributes.merge! addressee_attributes
          attributes[:line_items_attributes] = line_items_attributes
          attributes
        end

        def addressee_attributes
          return {} unless declared(params)[:type]
          if create_debit_invoice?
            {
              customer_id: params[:address_id],
              company_id: current_tenant.company.id,
            }
          else
            {
              customer_id: current_tenant.company.id,
              company_id: params[:address_id],
            }
          end
        end

        def line_items_attributes
          persistable_line_items_attributes | removable_line_items_attributes
        end

        def persistable_line_items_attributes
          line_items_param.map do |line_item|
            item = line_item.except(:credit_account_code, :debit_account_code)
            item[:credit_account] = Account.find_by_code(line_item[:credit_account_code])
            item[:debit_account] = Account.find_by_code(line_item[:debit_account_code])
            item
          end
        end

        def removable_line_items_attributes
          return [] unless params[:id]
          Invoice.find(params[:id]).line_items.map do |line_item|
            next if line_items_param.detect { |item| item[:id] == line_item.id }
            { id: line_item.id, _destroy: true }
          end.compact
        end

        def line_items_param
          declared(params)[:line_items]
        end
      end

      resource :invoices do
        desc 'Fetch all the invoices'
        get do
          invoices = Invoice.all
          present invoices, with: Bookyt::Entities::Invoice
        end

        before do
          Rails.logger.info params.inspect
        end
        desc 'Create a new invoice'
        params do
          requires :title, type: String, desc: 'Title of the invoice'
          requires :address_id, type: Integer, desc: 'ID of the company or customer'
          requires :type, type: String, values: %w(debit credit), desc: 'Type of the invoice (debit or credit)'
          requires :state, type: String, values: Invoice::STATES, default: 'booked', desc: 'Current state'
          requires :value_date, type: Date, desc: 'Value date of the invoice'
          requires :due_date, type: Date, desc: 'Due date of the invoice'

          optional :duration_from, type: Date, desc: 'Duration start of the invoice'
          optional :duration_to, type: Date, desc: 'Duration end of the invoice'
          optional :text, type: String, desc: 'Additional invoice text'
          optional :remarks, type: String, desc: 'Internal remarks'

          requires :line_items, type: Array do
            requires :title, type: String, desc: 'Title/Description of the line item'
            requires :times, type: BigDecimal, default: 1, desc: 'Price multiplier'
            requires :quantity, type: String, default: 'x', values: %w(x hours overall %), desc: 'Quantity'
            requires :price, type: BigDecimal, desc: 'Price of the line item, without modifiers applied'
            requires :credit_account_code, type: String, values: -> { Account.pluck(:code) }, desc: 'Code of the credit account'
            requires :debit_account_code, type: String,  values: -> { Account.pluck(:code) }, desc: 'Code of the debit account'

            optional :date, type: Date, desc: 'Date of the line item'
          end
        end
        post do
          invoice_klass = create_debit_invoice? ? DebitInvoice : CreditInvoice
          invoice = invoice_klass.create!(invoice_params)
          present invoice, with: Bookyt::Entities::Invoice
        end

        route_param :id do
          desc 'Fetch a invoice'
          get do
            invoice = Invoice.find(params[:id])
            present invoice, with: Bookyt::Entities::Invoice
          end

          desc 'Fetch a debit invoice as pdf'
          get 'pdf' do
            invoice = DebitInvoice.find(params[:id])
            pdf = DebitInvoicePDF.new(invoice, current_tenant)
            content_type Mime::Type.lookup_by_extension('pdf').to_s
            env['api.format'] = :binary
            header 'Content-Disposition', "attachment; filename=#{URI.escape(pdf.filename)}"
            pdf.call
          end

          desc 'Update a invoice'
          params do
            requires :title, type: String, desc: 'Title of the invoice'
            requires :state, type: String, values: Invoice::STATES, default: 'booked', desc: 'Current state'
            requires :value_date, type: Date, desc: 'Value date of the invoice'
            requires :due_date, type: Date, desc: 'Due date of the invoice'

            optional :duration_from, type: Date, desc: 'Duration start of the invoice'
            optional :duration_to, type: Date, desc: 'Duration end of the invoice'
            optional :text, type: String, desc: 'Additional invoice text, visible to customer'
            optional :remarks, type: String, desc: 'Internal remarks, not visible to customer'

            requires :line_items, type: Array do
              optional :id, type: Integer, desc: 'The ID of the line item'
              requires :title, type: String, desc: 'Title/Description of the line item'
              requires :times, type: BigDecimal, default: 1, desc: 'Price multiplier'
              requires :quantity, type: String, default: 'x', values: %w(x hours overall %), desc: 'Quantity'
              requires :price, type: BigDecimal, desc: 'Price of the line item, without modifiers applied'
              requires :credit_account_code, type: String, values: -> { Account.pluck(:code) }, desc: 'Code of the credit account'
              requires :debit_account_code, type: String, values: -> { Account.pluck(:code) }, desc: 'Code of the debit account'

              optional :date, type: Date, desc: 'Date of the line item'
            end
          end
          put do
            invoice = Invoice.find(params[:id])
            invoice.update_attributes!(invoice_params)
            present invoice, with: Bookyt::Entities::Invoice
          end

          desc 'Delete a invoice'
          delete do
            Invoice.find(params[:id]).destroy
            status 204
          end
        end
      end
    end
  end
end
