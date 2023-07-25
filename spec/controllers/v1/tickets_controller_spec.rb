require 'rails_helper'

RSpec.describe Api::V1::TicketsController, type: :controller do
  let(:valid_ticket_params) do
    {
      RequestNumber: '123',
      SequenceNumber: '1',
      RequestType: 'normal',
      DateTimes: { ResponseDueDateTime: '2023-07-25T08:00:00Z' },
      ServiceArea: {
        PrimaryServiceAreaCode: { SACode: 'XYZ' },
        AdditionalServiceAreaCodes: { SACode: ['ABC', 'DEF'] }
      },
      DigsiteInfo: { WellKnownText: 'POINT (30 10)' },
      Excavator: {
        CompanyName: 'Excavator Company',
        Address: '123 Main St',
        City: 'City',
        State: 'ST',
        Zip: '12345',
        CrewOnsite: 'true'
      }
    }
  end

  describe '#create' do
    context 'when params are valid' do
      before do
        allow_any_instance_of(ExternalRequests::BuildTicket).to receive(:call).and_return(FactoryBot.build(:ticket))
      end

      it 'creates a ticket' do
        expect { post :create, params: valid_ticket_params }.to change(Ticket, :count).by(1)
      end

      it 'returns status created' do
        post :create, params: valid_ticket_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the ticket has errors' do
      before do
        allow_any_instance_of(ExternalRequests::BuildTicket).to receive(:call).and_return(FactoryBot.build(:ticket))
        allow_any_instance_of(Ticket).to receive(:save).and_return(false)
        allow_any_instance_of(Ticket).to receive(:errors).and_return(['Error Message'])
      end

      it 'does not create a ticket' do
        expect { post :create, params: valid_ticket_params }.to_not change(Ticket, :count)
      end

      it 'returns status unprocessable_entity' do
        post :create, params: valid_ticket_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when params are invalid' do
      let(:invalid_ticket_params) { { invalid_param: 'invalid' } }

      it 'does not create a ticket' do
        expect { post :create, params: invalid_ticket_params }.to_not change(Ticket, :count)
      end

      it 'returns status unprocessable_entity' do
        post :create, params: invalid_ticket_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
