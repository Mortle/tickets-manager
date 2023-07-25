require 'rails_helper'

RSpec.describe ExternalRequests::BuildTicket, type: :interactor do
  let(:permitted_params) do
    {
      "RequestNumber" => "09252012-00001",
      "SequenceNumber" => "2421",
      "RequestType" => "Normal",
      "DateTimes" => {
        "ResponseDueDateTime" => "2011/07/13 23:59:59"
      },
      "ServiceArea" => {
        "PrimaryServiceAreaCode" => {
          "SACode" => "ZZGL103"
        },
        "AdditionalServiceAreaCodes" => {
          "SACode" => [
            "ZZL01",
            "ZZL02",
            "ZZL03"
          ]
        }
      },
      "DigsiteInfo" => {
        "WellKnownText" => "POLYGON((...))"
      },
      "Excavator" => {
        "CompanyName" => "John Doe CONSTRUCTION",
        "Address" => "555 Some RD",
        "City" => "SOME PARK",
        "State" => "ZZ",
        "Zip" => "55555",
        "CrewOnsite" => "true"
      }
    }
  end

  let(:raw_data) { { 'foo' => 'bar' } }

  let(:params) {
    {
      permitted_params: permitted_params.deep_symbolize_keys,
      raw_data: raw_data
    }
  }

  subject(:context) { described_class.call(params) }

  describe '#call' do
    it "succeeds" do
      expect(context).to be_a_success
    end

    it 'builds a new ticket' do
      expect(context.ticket).to be_a(Ticket)
    end

    it 'assigns the correct attributes to the ticket' do
      expect(context.ticket.request_number).to eq(permitted_params["RequestNumber"])
      expect(context.ticket.sequence_number).to eq(permitted_params["SequenceNumber"])
      expect(context.ticket.request_type).to eq(permitted_params["RequestType"])
      expect(context.ticket.response_due_timestamp).to eq(DateTime.parse(permitted_params["DateTimes"]["ResponseDueDateTime"]))
      expect(context.ticket.primary_sa_code).to eq(permitted_params.dig("ServiceArea", "PrimaryServiceAreaCode", "SACode"))
      expect(context.ticket.additional_sa_codes).to eq(permitted_params.dig("ServiceArea", "AdditionalServiceAreaCodes", "SACode"))
      expect(context.ticket.polygon).to eq(permitted_params.dig("DigsiteInfo", "WellKnownText"))
      expect(context.ticket.external_data).to eq(raw_data)
    end

    it 'assigns the correct attributes to the excavator' do
      expect(context.ticket.excavator.company_name).to eq(permitted_params.dig("Excavator", "CompanyName"))
      expect(context.ticket.excavator.crew_on_site).to eq(permitted_params.dig("Excavator", "CrewOnsite") == 'true')
    end

    it 'builds an address for the excavator' do
      expect(context.ticket.excavator.full_address).to include(permitted_params.dig("Excavator", "Address"))
      expect(context.ticket.excavator.full_address).to include(permitted_params.dig("Excavator", "City"))
      expect(context.ticket.excavator.full_address).to include(permitted_params.dig("Excavator", "State"))
      expect(context.ticket.excavator.full_address).to include(permitted_params.dig("Excavator", "Zip"))
    end

    it 'saves external data' do
      expect(context.ticket.external_data).to eq(raw_data)
    end
  end
end
