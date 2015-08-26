# coding: UTF-8

require 'spec_helper'

# TODO: hacked locales, reset at end of file
I18n.locale = 'en'

describe Api::ApiController do
  describe '#no_authentication!' do
    controller(Api::ApiController) do
      no_authentication!
      skip_load_and_authorize_resource

      def index
        render text: 'ok'
      end
    end

    context 'without a logged in user' do
      before do
        xhr :get, :index
      end

      it 'should be ok' do
        is_expected.to respond_with(:ok)
      end

      it 'returns the normal response' do
        expect(response.body).to eql 'ok'
      end
    end

    context 'with options passed' do
      controller(Api::ApiController) do
        no_authentication! only: :index
        skip_load_and_authorize_resource

        def index
          render text: 'ok'
        end

        def show
          render text: 'ok'
        end
      end

      context 'without a logged in user' do
        it 'index should be ok' do
          xhr :get, :index
          is_expected.to respond_with(:ok)
        end

        it 'show returns unauthenticated' do
          xhr :get, :show, id: 1
          expect(response.status).to eq(401)
        end
      end
    end
  end

  describe '#auth_token' do
    controller(Api::ApiController) do
      skip_load_and_authorize_resource

      def index
        respond_with({ email: current_user.email })
      end
    end

    before do
      user = FactoryGirl.create(:user, email: 'admin@test.com')
      auth_token = user.reload.authentication_token
      request.env['Auth-Token'] = auth_token
      xhr :get, :index
    end

    it 'should be authorized' do
      is_expected.to respond_with(:ok)
    end

    it 'sets the current user from the token' do
      expect(parse_json(response.body, 'email')).to eq 'admin@test.com'
    end
  end

  describe '#authenticate!' do
    controller(Api::ApiController) do
      skip_load_and_authorize_resource

      def index
        render text: 'ok'
      end
    end

    before { xhr :get, :index }

    it 'should be unauthorized' do
      is_expected.to respond_with(:unauthorized)
    end

    it 'returns a negative success' do
      expect(parse_json(response.body, 'success')).to eql false
    end

    it 'returns a meaningful message' do
      expect(parse_json(response.body, 'message')).to eql 'Access denied, please log in first.'
    end
  end

  describe '#unauthorized!' do
    controller(Api::ApiController) do
      skip_load_and_authorize_resource

      def index
        raise CanCan::AccessDenied.new('Access denied')
      end
    end

    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      xhr :get, :index
    end

    it 'should be forbidden' do
      is_expected.to respond_with(:forbidden)
    end

    it 'returns a negative success' do
      expect(parse_json(response.body, 'success')).to eql false
    end

    it 'returns a meaningful message' do
      expect(parse_json(response.body, 'message')).to eql 'Access denied'
    end
  end

  describe '#not_found!' do
    context 'for a missing ActiveRecord model' do
      controller(Api::ApiController) do
        skip_load_and_authorize_resource

        def index
          raise ActiveRecord::RecordNotFound.new("Couldn't find Account with ID=1")
        end
      end

      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in user
      end

      context 'without a specific not found message' do
        before do
          xhr :get, :index
        end

        it 'should be not found' do
          is_expected.to respond_with(:not_found)
        end

        it 'returns a negative success' do
          expect(parse_json(response.body, 'success')).to eql false
        end

        it 'returns a meaningful message' do
          expect(parse_json(response.body, 'message')).to eql 'The resource was not found.'
        end
      end

      context 'with a specific not found message' do
        before do
          expect(I18n).to receive(:t).with('rest.not_found.default').and_return 'Default message'
          expect(I18n).to receive(:t).with('rest.not_found.api.index', { default: 'Default message' }).and_return 'Custom message'
          xhr :get, :index
        end

        it 'should be not found' do
          is_expected.to respond_with(:not_found)
        end

        it 'returns a negative success' do
          expect(parse_json(response.body, 'success')).to eql false
        end

        it 'returns a meaningful message' do
          expect(parse_json(response.body, 'message')).to eql 'Custom message'
        end
      end
    end
  end

  describe '#stale_object!' do
    controller(Api::ApiController) do
      skip_load_and_authorize_resource

      def index
        raise ActiveRecord::StaleObjectError.new(nil, :index)
      end
    end

    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      xhr :get, :index
    end

    it 'should be conflict' do
      is_expected.to respond_with(:conflict)
    end

    it 'returns a negative success' do
      expect(parse_json(response.body, 'success')).to eql false
    end

    it 'returns a meaningful message' do
      expect(parse_json(response.body, 'message')).to eql 'Another user has changed the data already.'
    end
  end

  describe '#not_acceptable!' do
    context 'when JSON parsing fails' do
      controller(Api::ApiController) do
        skip_load_and_authorize_resource

        def index
          raise JSON::ParserError.new('Cannot parse JSON document')
        end
      end

      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in user
        xhr :get, :index
      end

      it 'should be not found' do
        is_expected.to respond_with(:not_acceptable)
      end

      it 'returns a negative success' do
        expect(parse_json(response.body, 'success')).to eql false
      end

      it 'returns a meaningful message' do
        expect(parse_json(response.body, 'message')).to eql 'The data is not valid.'
      end
    end
  end
end

# TODO: see beginning of file
I18n.locale = 'de-CH'
