module Bookyt
  class API
    class DebitDirectFiles < Grape::API
      resource :debit_direct_files do
        desc 'Fetch all the debit_direct_files'
        get do
          debit_direct_files = DebitDirectFile.all
          present debit_direct_files, with: Bookyt::Entities::DebitDirectFile
        end

        desc 'Create a new debit_direct_file'
        params do
          optional :invoices, type: Array[Fixnum]
        end
        post do
          bank_account = Account.find_by_tag('invoice:vesr')
          debit_direct_file = DebitDirectFileCreator.call(current_tenant, bank_account, params[:invoices])
          present debit_direct_file, with: Bookyt::Entities::DebitDirectFile
        end

        route_param :id do
          desc 'Fetch a debit_direct_file'
          get do
            debit_direct_file = DebitDirectFile.find(params[:id])
            present debit_direct_file, with: Bookyt::Entities::DebitDirectFile
          end
        end
      end
    end
  end
end
