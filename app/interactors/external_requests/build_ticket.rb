# frozen_string_literal: true

module ExternalRequests
  class BuildTicket
    include Interactor

    delegate :ticket, :permitted_params, :raw_data, to: :context

    def call
      context.ticket = Ticket.new(ticket_params)
    end

    private

    def ticket_params
      {
        request_number: permitted_params[:RequestNumber],
        sequence_number: permitted_params[:SequenceNumber],
        request_type: permitted_params[:RequestType],
        response_due_timestamp: permitted_params.dig(:DateTimes, :ResponseDueDateTime),
        primary_sa_code: permitted_params.dig(:ServiceArea, :PrimaryServiceAreaCode, :SACode),
        additional_sa_codes: build_additional_sa_codes,
        polygon: permitted_params.dig(:ExcavationInfo, :DigsiteInfo, :WellKnownText),
        excavator_attributes:,
        external_data: raw_data
      }
    end

    def build_additional_sa_codes
      Array(permitted_params.dig(:ServiceArea, :AdditionalServiceAreaCodes, :SACode)).compact_blank
    end

    def excavator_attributes
      {
        company_name: permitted_params.dig(:Excavator, :CompanyName),
        full_address: build_full_address,
        crew_on_site: permitted_params.dig(:Excavator, :CrewOnsite) == 'true'
      }
    end

    def build_full_address
      [
        permitted_params.dig(:Excavator, :Address),
        permitted_params.dig(:Excavator, :City),
        permitted_params.dig(:Excavator, :State),
        permitted_params.dig(:Excavator, :Zip)
      ].compact_blank.join(', ')
    end
  end
end
