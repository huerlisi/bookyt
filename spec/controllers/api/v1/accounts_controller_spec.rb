require 'spec_helper'

describe Api::V1::AccountsController do
  describe '#index' do
    context 'when not authenticated' do
      it 'returns with unauthorized' do
        xhr :get, :index, :format => :json
        should respond_with(:unauthorized)
      end
    end

    context 'when authenticated' do
      let!(:bank_account){ FactoryGirl.create(:bank_account) }
      let!(:cash_account){ FactoryGirl.create(:cash_account) }

      before do
        user = FactoryGirl.create(:user)
        sign_in user

        xhr :get, :index, :format => :json
      end

      it 'returns success' do
        response.status.should == 200
      end

      it 'returns 2 records' do
        parse_json(response.body, 'accounts').count.should == 2
      end

      it 'returns records with account ids' do
        id_1 = parse_json(response.body, 'accounts/0/id')
        id_2 = parse_json(response.body, 'accounts/1/id')

        [id_1, id_2].sort.should == [bank_account.id, cash_account.id].sort
      end
    end
  end
end
