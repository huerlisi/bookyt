require 'spec_helper'

RSpec.describe CustomerParams do
  let(:params) do
    {
      name: 'Bruce Lee',
      street: 'Leestreet 12a',
      zip: '1234567',
      city: 'China City',
      phone_numbers: [
        {
          type: 'office',
          number: '1234556778',
        }
      ]
    }
  end
  let(:instance) { described_class.new(params) }

  describe '#to_h' do
    subject { instance.to_h }

    context 'customer exists' do
      let(:customer) { FactoryGirl.create(:customer) }
      let(:hash) do
        {
          vcard_attributes: {
            id: customer.id,
            full_name: 'Bruce Lee',
            address_attributes: {
              extended_address: nil,
              street_address: 'Leestreet 12a',
              post_office_box: nil,
              postal_code: '1234567',
              locality: 'China City',
            },
            contacts_attributes: {
              0 => {
                id: nil,
                phone_number_type: 'Tel. geschäft',
                number: '1234556778',
              }
            },
          }
        }
      end
      before do
        params[:id] = customer.id
      end

      it { is_expected.to eq(hash) }

      context "customer doesn't have a phone number" do
        specify { expect(subject[:vcard_attributes][:contacts_attributes][0][:id]).to eq(nil) }
      end

      context 'customer has a phone number' do
        let!(:phone_id) do
          customer.vcard.contacts.create!(phone_number_type: 'Tel. geschäft', number: '123').id
        end

        specify { expect(subject[:vcard_attributes][:contacts_attributes][0][:id]).to eq(phone_id) }
      end
    end

    context 'customer does not exist' do
      let(:hash) do
        {
          vcard_attributes: {
            full_name: 'Bruce Lee',
            address_attributes: {
              extended_address: nil,
              street_address: 'Leestreet 12a',
              post_office_box: nil,
              postal_code: '1234567',
              locality: 'China City',
            },
            contacts_attributes: {
              0 => {
                phone_number_type: 'Tel. geschäft',
                number: '1234556778',
              }
            },
          }
        }
      end

      it { is_expected.to eq(hash) }
    end
  end
end
