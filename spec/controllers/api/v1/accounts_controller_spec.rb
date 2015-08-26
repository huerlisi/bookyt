require 'spec_helper'

describe Api::V1::AccountsController do
  describe '#index' do
    context 'when not authenticated' do
      it 'returns with unauthorized' do
        xhr :get, :index, :format => :json
        is_expected.to respond_with(:unauthorized)
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
        expect(response.status).to eq(200)
      end

      it 'returns 2 records' do
        expect(parse_json(response.body, 'accounts').count).to eq(2)
      end

      it 'returns records with account ids' do
        id_1 = parse_json(response.body, 'accounts/0/id')
        id_2 = parse_json(response.body, 'accounts/1/id')

        expect([id_1, id_2].sort).to eq([bank_account.id, cash_account.id].sort)
      end
    end
  end
end
